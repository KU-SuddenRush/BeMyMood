package ku.hackerthon.BeMyMood.service.member;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.bookmark.Bookmark;
import ku.hackerthon.BeMyMood.domain.member.bookmark.Bookmarks;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocation;
import ku.hackerthon.BeMyMood.domain.member.mood.MoodAccumulations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMood;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.domain.review.ReviewImage;
import ku.hackerthon.BeMyMood.domain.review.ReviewImages;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.member.response.BookmarkResponseDto;
import ku.hackerthon.BeMyMood.dto.storage.StorageDomain;
import ku.hackerthon.BeMyMood.dto.web.response.MemberInfoResponseDto;
import ku.hackerthon.BeMyMood.dto.web.request.ReviewRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.ReviewResponseDto;
import ku.hackerthon.BeMyMood.respository.MemberRepository;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
import ku.hackerthon.BeMyMood.service.location.LocationService;
import ku.hackerthon.BeMyMood.service.mood.MoodService;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import ku.hackerthon.BeMyMood.service.storage.StorageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Transactional
@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

    private final MemberRepository memberRepository;
    private final MoodService moodService;
    private final LocationService locationService;
    private final SpotService spotService;
    private final StorageService storageService;

    @Override
    public Long join(MemberJoinParams params) {
        Member member = Member.builder()
                .name(params.getName())
                .email(params.getEmail())
                .password(params.getPassword())
                .build();

        return memberRepository.save(member);
    }

    @Override
    public Member searchByEmail(String email) throws IllegalArgumentException {
        return memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("wrong email"));
    }

    @Override
    public Member searchById(Long memberId) throws IllegalArgumentException {
        return memberRepository.findById(memberId)
                .orElseThrow(() -> new IllegalArgumentException("wrong id"));
    }

    @Override
    public MemberInfoResponseDto searchMemberInfoById(Long memberId) {
        Member member = searchById(memberId);
        return new MemberInfoResponseDto(
                member.getId(),
                member.getName(),
                member.getEmail()
        );
    }

    @Override
    public void setMemberMood(List<Long> moodIds, Long memberId) {
        Member member = searchById(memberId);

        for (Long moodId : moodIds) {
            Mood selectedMood = moodService.getById(moodId);

            // 이미 선택한 무드 -> 생략
            if (member.getPreferredMoods().hasMood(selectedMood)) continue;

            member.addMood(new PreferredMood(member, selectedMood));
        }
    }

    @Override
    public List<Long> getPreferredMoodIds(Long memberId) {
        Member member = searchById(memberId);
        PreferredMoods preferredMoods = member.getPreferredMoods();
        return preferredMoods.getIds();
    }

    @Override
    public List<BookmarkResponseDto> getBookmarks(Long memberId) {
        Member member = searchById(memberId);
        Bookmarks bookmarks = member.getBookmarks();

        List<BookmarkResponseDto> bookmarkResponseDtoList = bookmarks.getSpots().stream()
                .map(spot -> new BookmarkResponseDto(
                        spot.getSpotImages().getMainImage().getImgUrl(),
                        spot.getId(),
                        spot.getName(),
                        spot.getSpotMoods().getMoodNames(),
                        spot.getAddress(),
                        spot.getCategory().getName()
                )).collect(Collectors.toList());

        return bookmarkResponseDtoList;
    }

    @Override
    public boolean setBookmark(Member member, Spot spot) {
        boolean isBookmarked = member.getBookmarks().hasSpot(spot);
        if (isBookmarked) {
            Bookmark bookmark = member.getBookmarks().findBySpot(spot);
            member.removeBookmark(bookmark);
            return false;
        }

        member.addBookmark(new Bookmark(member, spot));
        return true;
    }

    @Override
    public boolean setMemberLocation(List<Long> locationIds, Long memberId) {
        Member member = searchById(memberId);

        locationIds.stream()
                .map(locationId -> new PreferredLocation(member, locationService.getById(locationId)))
                .forEach(member::addLocation);
        return true;
    }

    @Override
    public List<String> getPreferredLocationNames(Long memberId) {
        Member member = searchById(memberId);
        return member.getPreferredLocations().getNames();
    }

    @Override
    public void review(ReviewRequestDto requestDto, Long spotId, Long memberId) throws IOException {
        Member member = searchById(memberId);
        Spot spot = spotService.searchById(spotId);
        Review review = new Review(
                requestDto.getDescription(),
                LocalDate.now(),
                requestDto.getOpened(),
                member,
                spot
        );

        storeMoodAccumulation(member, spot.getSpotMoods().getMoods());
    }

    private void storeMoodAccumulation(Member member, List<Mood> moods) {
        MoodAccumulations moodAccumulations = member.getMoodAccumulations();
        moods.forEach(mood -> moodAccumulations.addMood(member, mood));
    }

    @Override
    public List<ReviewResponseDto> findAllReviewByMemberID(Long memberId) {
        Member member = searchById(memberId);
        List<Review> allReview = member.getReviews()
                .getAllReview();

        return allReview.stream()
                .map(review -> new ReviewResponseDto(
                            member.getName(),
                            review.getReviewImages().getImageUrls(),
                            review.getDescription(),
                            review.getPostAt(),
                            review.getOpened()
                    )
                ).collect(Collectors.toList());
    }

    @Override
    public void setReviewImages(Long spotId, Long memberId, List<MultipartFile> files) {
        Member member = searchById(memberId);
        Spot spot = spotService.searchById(spotId);
        Review review = member.getReviews().getReviewBySpot(spot);
        ReviewImages reviewImages = review.getReviewImages();

        files.stream()
                .forEach(file -> {
                            String fileName = storageService.setFileName(review.getId(), file, StorageDomain.REVIEW);
                            try {
                                String uploadUrl = storageService.uploadToS3(file, fileName);
                                reviewImages.add(new ReviewImage(uploadUrl, review));
                            } catch (IOException e) {
                                throw new RuntimeException("S3 업로드 실패");
                            }
                        }
                );
    }
}
