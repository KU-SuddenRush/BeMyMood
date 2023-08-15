package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.dto.moodboard.SpotSignatureImageParams;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import ku.hackerthon.BeMyMood.dto.web.request.SpotSignatureImagesResponseDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.moodboard.MoodBoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/moodboard")
@RestController
public class MoodBoardController {
    private final MemberService memberService;
    private final MoodBoardService moodBoardService;

    /**
     * <b>MoodBoard 생성</b>
     *
     * @param memberId {@link State}로 주입된 MemberId,
     *        requestDto 무드보드 생성에 필요한 데이터 dto,
     *        file 무드보드 캡쳐 파일
     *
     * @return
     */
    @PostMapping
    public ResponseEntity<String> createMoodBoard(
            @State Long memberId,
            @RequestPart("data") MoodBoardRequestDto requestDto,
            @RequestPart("file") MultipartFile file
            ) {
        Member member = memberService.searchById(memberId);

        // 무드보드 생성
        moodBoardService.moodBoard(member, file, requestDto);

        return ResponseEntity.ok("무드보드가 생성되었습니다.");
    }

    /**
     * <b>무드보드 아이템 - 스팟 시그니처 사진 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     *
     * @return SpotSignatureImagesResponseDto
     */
    @GetMapping("/picture/spot-signature")
    public ResponseEntity<SpotSignatureImagesResponseDto> getSpotSignatureImages(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        List<Review> allOpenReviews = member.getReviews().getAllReview().stream()
                .filter(review -> review.isOpen())
                .collect(Collectors.toList());

        return ResponseEntity.ok(new SpotSignatureImagesResponseDto(
                allOpenReviews.stream()
                        .map(review -> new SpotSignatureImageParams(
                                review.getSpot().getSpotImages().getMainImage().getId(),
                                review.getSpot().getSpotImages().getMainImage().getImgUrl()
                        )).collect(Collectors.toList())));

    }

}
