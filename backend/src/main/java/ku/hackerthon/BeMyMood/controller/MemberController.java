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

    /**
     * <b>Member의 간단한 정보 조회 (테스트용)</b>
     *
     * @param memberId {@link State}로 주입된 MemberId <- 세션 저장소에 저장된 MemberId
     * @return
     */
    @GetMapping("/info")
    public ResponseEntity<MemberInfoResponseDto> getMemberInfo(@State Long memberId) {
        MemberInfoResponseDto responseDto = memberService.searchMemberInfoById(memberId);
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>이미지 업로드 (테스트영)</b>
     *
     * @param file 업로드할 사진
     * @return
     */
    @PostMapping("/image")
    public ResponseEntity<String> uploadImage(@RequestPart(name = "file") MultipartFile file) throws IOException {
        String uploadedUrl = storageService.uploadToS3(file, randomFileName());
        return ResponseEntity.ok(uploadedUrl);
    }

    private static String randomFileName() {
        return UUID.randomUUID().toString().substring(8);
    }

    /**
     * <b>Member의 색상/분위기 취향 입력</b>
     * @param memberId {@link State}로 주입된 MemberId,
     *                 List<String> 색상/분위기 리스트
     */
    @PostMapping("/mood")
    public ResponseEntity<String> setMemberMood(
            @RequestBody MemberMoodRequestDto requestDto,
            @State Long memberId) {
        memberService.setMemberMood(requestDto.getMoods(), memberId);
        return ResponseEntity.ok("내가 좋아하는 무드 저장에 성공하였습니다.");
    }

    /**
     * <b>나의 무드 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return List<String>
     */
    @GetMapping("/mood")
    public ResponseEntity<List<String>> getMemberMood(@State Long memberId) {
        List<String> response = memberService.getPreferredMoodNames(memberId);
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
    public ResponseEntity<List<String>> getMemberLocation(@State Long memberId) {
        List<String> response = memberService.getPreferredLocationNames(memberId);
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
     * @param files
     * @param memberId
     * @return
     * @throws IOException
     */
    @PostMapping("/review")
    public ResponseEntity<String> review(
            @RequestPart("data") ReviewRequestDto requestDto,
            @RequestPart("files") List<MultipartFile> files,
            @State Long memberId
    ) throws IOException {
        memberService.review(requestDto, memberId);

        // 한 회원이 하나의 가게에 작성할 수 있는 리뷰를 1개로 제한
        memberService.setReviewImages(requestDto.getSpotId(), memberId, files);

        return ResponseEntity.ok("리뷰 등록에 성공했습니다.");
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