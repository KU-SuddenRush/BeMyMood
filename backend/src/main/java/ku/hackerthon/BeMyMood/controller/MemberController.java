package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.dto.member.request.MemberMoodRequestDto;
import ku.hackerthon.BeMyMood.dto.web.request.MemberInfoResponseDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;

    /**
     * <b>Member의 간단한 정보 조회 (테스트용)</b>
     * @param memberId {@link State}로 주입된 MemberId <- 세션 저장소에 저장된 MemberId
     * @return
     */
    @GetMapping("/info")
    public ResponseEntity<MemberInfoResponseDto> getMemberInfo(@State Long memberId) {
        MemberInfoResponseDto responseDto = memberService.searchMemberInfoById(memberId);
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>Member의 색상/분위기 취향 입력</b>
     * @param memberId {@link State}로 주입된 MemberId,
     *        List<String> 색상/분위기 리스트
     * */
    @PostMapping("/mood")
    public ResponseEntity<String> setMemberMood(
            @RequestBody MemberMoodRequestDto requestDto,
            @State Long memberId) {
        memberService.setMemberMood(requestDto.getMoods(), memberId);
        return ResponseEntity.ok("내가 좋아하는 무드 저장에 성공하였습니다.");
    }
}