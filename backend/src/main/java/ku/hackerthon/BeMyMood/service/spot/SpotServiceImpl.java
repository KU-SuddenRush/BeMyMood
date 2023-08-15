package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.review.PublicReviews;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.domain.spot.SpotCategory;
import ku.hackerthon.BeMyMood.domain.spot.SpotImage;
import ku.hackerthon.BeMyMood.domain.spot.SpotImages;
import ku.hackerthon.BeMyMood.dto.spot.*;
import ku.hackerthon.BeMyMood.dto.storage.StorageDomain;
import ku.hackerthon.BeMyMood.dto.web.request.SpotCreateRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.*;
import ku.hackerthon.BeMyMood.respository.SpotRepository;
import ku.hackerthon.BeMyMood.service.location.LocationService;
import ku.hackerthon.BeMyMood.service.mood.MoodService;
import ku.hackerthon.BeMyMood.service.storage.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Transactional
@RequiredArgsConstructor
@Service
public class SpotServiceImpl implements SpotService {

    private final SpotRepository spotRepository;
    private final LocationService locationService;
    private final MoodService moodService;
    private final StorageService storageService;

    /**
     * 새로운 스팟을 등록
     */
    @Override
    public Long register(SpotCreateRequestDto requestDto) {
        return spotRepository.save(new Spot(
                        requestDto.getName(),
                        requestDto.getAddress(),
                        requestDto.getContact(),
                        requestDto.getIntroduce(),
                        SpotCategory.ofName(requestDto.getCategoryName()),
                        locationService.getById(requestDto.getLocationId()),
                        requestDto.getOpenAt(),
                        requestDto.getCloseAt()
                )
        );
    }

    /**
     * 등록된 모든 스팟을 검색
     */
    @Override
    public List<Spot> getAll() {
        return spotRepository.findAll();
    }

    @Override
    public AllSpotInfoResponseDto getAllInfo() {
        List<Spot> allSpot = getAll();

        return new AllSpotInfoResponseDto(
                allSpot.stream()
                        .map(spot -> new SpotInfo(
                                        spot.getId(),
                                        true,
                                        spot.getName(),
                                        spot.getSpotImages().getMainImage().getImgUrl(),
                                        spot.getCategory().name(),
                                        spot.getSpotMoods().getMoodNames()
                                )
                        ).collect(Collectors.toList())
        );
    }

    /**
     * <b>spot의 id로 스팟 조회</b>
     * @param spotId
     * @return
     */
    @Override
    public Spot searchById(Long spotId) {
        return spotRepository.findById(spotId)
                .orElseThrow(() -> new IllegalArgumentException("wrong spot id"));
    }

    /**
     * <b>[ 카테고리 / 위치 / 무드 ]로 스팟 리스트를 검색</b>
     * @param params -> 각 필드각 nullable
     */
    @Override
    public FilteredSpotsResponseDto filter(SpotFilterParams params) {

        List<Spot> collectByLocation = collectByLocation(params);
        List<Spot> collectByCategory = collectByCategory(collectByLocation, params);
        List<Spot> collectByMood = collectByMood(collectByCategory, params);

        return new FilteredSpotsResponseDto(
                collectByMood.stream()
                        .map(spot -> new FilteredSpotInfo(
                                spot.getId(),
                                spot.getName(),
                                spot.getSpotImages().getMainImage().getImgUrl(),
                                spot.getCategory().name(),
                                spot.getSpotMoods().getMoodNames()
                        )).collect(Collectors.toList())
        );
    }

    @Override
    public SpotDetailsResponseDto getSpotDetails(Spot spot, Member member) {
        return new SpotDetailsResponseDto(
                spot.getId(),
                member.bookmarked(spot),
                spot.getCategory().name(),
                spot.getName(),
                spot.getSpotMoods().getMoodNames(),
                spot.getSpotImages().getImageUrls(),
                spot.getAddress(),
                spot.getContact(),
                spot.getOperationInfo(),
                spot.getIntroduce()
        );
    }

    @Override
    public RecommendedSpotsResponseDto recommend(PreferredLocations preferredLocations, PreferredMoods preferredMoods) {

        List<Spot> preferredSpots = spotRepository.findAllPreferLocated(preferredLocations);
        Map<Spot, Integer> spotScores = new HashMap<>();
        preferredSpots.stream()
                .forEach(spot -> {
                    int matched = spot.getSpotMoods().countMatchingMoods(preferredMoods);
                    spotScores.put(spot, matched);
                });

        List<Spot> spotsOrderedByScore = spotScores.entrySet().stream()
                .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        return new RecommendedSpotsResponseDto(
                spotsOrderedByScore.stream()
                        .map(spot -> new RecommendedSpotInfo(
                                        spot.getId(),
                                        spot.getName(),
                                        spot.getSpotImages().getMainImage().getImgUrl(),
                                        spot.getCategory().name(),
                                        spot.getSpotMoods().getMoodNames()
                                )
                        ).collect(Collectors.toList())
        );
    }

    @Override
    public void registerImages(Long spotId, List<MultipartFile> files) {
        Spot spot = searchById(spotId);
        SpotImages spotImages = spot.getSpotImages();

        files.stream()
                .forEach(file -> {
                    String fileName = storageService.setFileName(spot.getId(), file, StorageDomain.SPOT);
                    try {
                        String uploadUrl = storageService.uploadToS3(file, fileName);
                        spotImages.add(new SpotImage(uploadUrl, spot));
                    } catch (IOException e) {
                        throw new RuntimeException("S3 업로드 실패");
                    }
                }
            );
    }

    @Override
    public SpotPublicReviewsResponseDto getSpotReviews(Spot spot) {
        List<Review> publicReviews = spot.getPublicReviews().getPublicReviews();

        // PostAt 최신 순(내림차순) 정렬
        publicReviews = publicReviews
                .stream()
                .sorted(Comparator.comparing(Review::getPostAt).reversed())
                .collect(Collectors.toList());

        return new SpotPublicReviewsResponseDto(
                publicReviews.stream()
                        .map(publicReview -> new SpotPublicReviewsInfo(
                                publicReview.getId(),
                                spot.getId(),
                                publicReview.getReviewImages().getImageUrls(),
                                publicReview.getDescription(),
                                publicReview.getPostAt()
                        )).collect(Collectors.toList())
        );
    }

    private List<Spot> collectByLocation(SpotFilterParams params) {
        if (params.getLocationId() != null) {
            Location location = locationService.getById(params.getLocationId());
            return spotRepository.findAllLocatedIn(location);
        }
        return getAll();
    }

    private List<Spot> collectByCategory(List<Spot> spots, SpotFilterParams params) {
        if (params.getCategoryId() != null) {
            SpotCategory category = SpotCategory.ofId(params.getCategoryId());
            return spots.stream()
                    .filter(spot -> spot.getCategory().equals(category))
                    .collect(Collectors.toList());
        }

        return spots;
    }

    private List<Spot> collectByMood(List<Spot> spots,  SpotFilterParams params) {
        if (params.getMoodId() != null) {
            Mood mood = moodService.getById(params.getMoodId());
            return spots.stream()
                    .filter(spot -> spot.hasMood(mood))
                    .collect(Collectors.toList());
        }

        return spots;
    }

    public SpotImage searchSpotImgById(Long spotImgId) {
        return spotRepository.findSpotImgById(spotImgId)
                .orElseThrow(() -> new IllegalArgumentException("wrong spot image id"));
    }
}
