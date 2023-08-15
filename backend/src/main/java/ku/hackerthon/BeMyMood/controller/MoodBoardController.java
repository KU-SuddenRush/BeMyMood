package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
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

}
