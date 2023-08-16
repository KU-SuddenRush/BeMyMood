package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.member.request.BookmarkSettingRequestDto;
import ku.hackerthon.BeMyMood.dto.member.request.MemberMoodRequestDto;
import ku.hackerthon.BeMyMood.dto.member.response.BookmarkResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.MemberInfoResponseDto;
import ku.hackerthon.BeMyMood.dto.web.request.MemberLocationRequestDto;
import ku.hackerthon.BeMyMood.dto.web.request.ReviewRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.MemberMoodResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.ReviewResponseDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import ku.hackerthon.BeMyMood.service.storage.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;
    private final StorageService storageService;
    private final SpotService spotService;

    private static String randomFileName() {
        return UUID.randomUUID().toString().substring(8);
    }

    /**
     * <b>Member의 색상/분위기 취향 입력/수정</b>
     * @param memberId {@link State}로 주입된 MemberId,
     *                 List<String> 색상/분위기 리스트
     */
    @PostMapping("/mood")
    public ResponseEntity<String> setMemberMood(
            @RequestBody MemberMoodRequestDto requestDto,
            @State Long memberId) {
        memberService.setMemberMood(requestDto.getMoodIds(), memberId);
        return ResponseEntity.ok("내가 좋아하는 무드 저장에 성공하였습니다.");
    }

    /**
     * <b>나의 무드 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return List<Long>
     */
    @GetMapping("/mood")
    public ResponseEntity<MemberMoodResponseDto> getMemberMood(@State Long memberId) {
        List<Long> moodNames = memberService.getPreferredMoodIds(memberId);
        MemberMoodResponseDto response = new MemberMoodResponseDto(moodNames.size(), moodNames);
        return ResponseEntity.ok(response);
    }

    /**
     * <b>내가 선호하는 위치 저장</b>
     * @param requestDto
     * @param memberId
     * @return
     */
    @PostMapping("/location")
    public ResponseEntity<String> setMemberLocation(
            @RequestBody MemberLocationRequestDto requestDto,
            @State Long memberId
    ) {
        if (memberService.setMemberLocation(requestDto.getLocationIds(), memberId)) {
            return ResponseEntity.ok("내가 좋아하는 위치 저장에 성공하였습니다.");
        }
        return ResponseEntity.ok("내가 좋아하는 위치 저장에 실패하였습니다.");
    }

    /**
     * <b>내가 선호하는 위치 조회</b>
     * @param memberId
     * @return
     */
    @GetMapping("/location")
    public ResponseEntity<List<Long>> getMemberLocation(@State Long memberId) {
        List<Long> response = memberService.getPreferredLocationNames(memberId);
        return ResponseEntity.ok(response);
    }

    /**
     * <b>나의 관심 스팟(즐겨찾기) 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return List<String>
     */
    @GetMapping("/bookmark")
    public ResponseEntity<List<BookmarkResponseDto>> getBookmarks(@State Long memberId) {
        List<BookmarkResponseDto> response = memberService.getBookmarks(memberId);
        return ResponseEntity.ok(response);
    }

    /**
     * <b>나의 관심 스팟(즐겨찾기) 등록/삭제</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return List<String>
     */
    @PostMapping("/bookmark")
    public ResponseEntity<String> setBookmark(@State Long memberId, @RequestBody BookmarkSettingRequestDto requestDto) {
        Member member = memberService.searchById(memberId);
        Spot spot = spotService.searchById(requestDto.getSpotId());
        if (memberService.setBookmark(member, spot)) { // 등록
            return ResponseEntity.ok("관심 스팟에 등록하였습니다.");
        }
        return ResponseEntity.ok("관심 스팟에서 삭제하였습니다.");
    }

    /**
     * <b>Member의 리뷰 등록</b>
     * @param requestDto
     * @param memberId
     * @return
     * @throws IOException
     */
    @PostMapping("/review/data")
    public ResponseEntity<String> reviewData(
            @RequestBody ReviewRequestDto requestDto,
            @RequestParam("spot-id") Long spotId,
            @State Long memberId
    ) throws IOException {
        memberService.review(requestDto, spotId, memberId);
        return ResponseEntity.ok("리뷰 정보 등록에 성공했습니다.");
    }

    /**
     * <b>Member의 리뷰 사진 등록</b>
     */
    @PostMapping("/review/image")
    public ResponseEntity<String> reviewImages(
            @RequestPart("images") List<MultipartFile> images,
            @RequestParam("spot-id") Long spotId,
            @State Long memberId
    ) throws IOException {
        // 한 회원이 하나의 가게에 작성할 수 있는 리뷰를 1개로 제한
        memberService.setReviewImages(spotId, memberId, images);
        return ResponseEntity.ok("리뷰 이미지 등록에 성공했습니다.");
    }

    /**
     * <b>Member의 전체 리뷰 조회</b>
     * @param memberId
     * @return
     */
    @GetMapping("/review")
    public ResponseEntity<List<ReviewResponseDto>> showAllReview(@State Long memberId) {
        List<ReviewResponseDto> requestDtos = memberService.findAllReviewByMemberID(memberId);
        return ResponseEntity.ok(requestDtos);
    }
}