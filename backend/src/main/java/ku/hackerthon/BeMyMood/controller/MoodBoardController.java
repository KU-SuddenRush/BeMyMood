package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import ku.hackerthon.BeMyMood.dto.moodboard.MoodBoardInfo;
import ku.hackerthon.BeMyMood.dto.web.response.*;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.moodboard.MoodBoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
     *        requestDto 무드보드 생성에 필요한 데이터 dto
     *
     * @return
     */
    @PostMapping
    public ResponseEntity<CreatMoodBoardResponseDto> createMoodBoard(
            @State Long memberId,
            @RequestBody MoodBoardRequestDto requestDto
            ) {
        Member member = memberService.searchById(memberId);

        // 무드보드 생성
        moodBoardService.moodBoard(member, requestDto);

        MoodBoard moodBoardId = moodBoardService.getLastCreatedMoodBoard(member);

        return ResponseEntity.ok(new CreatMoodBoardResponseDto(moodBoardId.getId()));
    }

    /**
     * <b>MoodBoard 캡처본 업로드</b>
     *
     * @param moodBoardId MemberId,
     *        file 무드보드 캡쳐 파일
     *
     * @return
     */
    @PostMapping("/capture")
    public ResponseEntity<StringResponseDto> storeCaptureImg(
            @RequestPart("file") MultipartFile file,
            @RequestParam(name = "mood_board_id") Long moodBoardId) {
        MoodBoard moodBoard = moodBoardService.findById(moodBoardId);
        moodBoardService.storeCaptureImg(file, moodBoard);

        return ResponseEntity.ok(new StringResponseDto("무드보드 캡쳐 이미지를 성공적으로 저장하였습니다."));
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
     * <b>무드보드 아이템 - 내 기록 사진 조회</b>
     *
     * @param memberId {@link State}로 주입된 MemberId
     *
     * @return ReviewImagesResponseDto
     */
    @GetMapping("/picture/review")
    public ResponseEntity<ReviewImagesResponseDto> getReviewImages(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        return ResponseEntity.ok(moodBoardService.getReviewImages(member));
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
