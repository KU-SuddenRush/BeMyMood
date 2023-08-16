package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.dto.moodboard.MoodBoardInfo;
import ku.hackerthon.BeMyMood.dto.moodboard.SpotSignatureImageParams;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import ku.hackerthon.BeMyMood.dto.web.request.SpotSignatureImagesResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.MoodBoardDetailResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.MoodBoardResponseDto;
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
        return ResponseEntity.ok(moodBoardService.getSpotSignatureImages(member));
    }

    /**
     * <b>저장된 무드보드 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return MoodBoardResponseDto
     */
    @GetMapping
    public ResponseEntity<MoodBoardResponseDto> getAllMoodBoards(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        return ResponseEntity.ok(moodBoardService.getAllMoodBoards(member));
    }

    /**
     * <b>가장 최근에 편집한 무드보드 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return MoodBoardResponseDto
     */
    @GetMapping("/last")
    public ResponseEntity<MoodBoardInfo> getLastEditedMoodBoard(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        return ResponseEntity.ok(moodBoardService.getLastEditedMoodBoard(member));

    }

    /**
     * <b>무드보드 상세 보기</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     * @return MoodBoardResponseDto
     */
    @GetMapping("/detail")
    public ResponseEntity<MoodBoardDetailResponseDto> getMoodBoardDetail(
            @State Long memberId,
            @RequestParam(name = "mood_board_id") Long moodBoardId
    ) {
        Member member = memberService.searchById(memberId);
        MoodBoard moodBoard = member.getMoodBoards().searchById(moodBoardId);

        return ResponseEntity.ok(moodBoardService.getMoodBoardDetail(moodBoard));
    }

}
