package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.dto.web.request.MemberInfoResponseDto;
import ku.hackerthon.BeMyMood.service.auth.state.StateManager;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@RequestMapping("/member")
@RestController
public class MemberController {

    private final MemberService memberService;
    private final StateManager<String, Long> stateManager;

    @GetMapping("/info")
    public ResponseEntity<MemberInfoResponseDto> getMemberInfo(HttpServletRequest request) {
        MemberInfoResponseDto responseDto = memberService.searchMemberInfoById(getMemberId(request));
        return ResponseEntity.ok(responseDto);
    }

    private Long getMemberId(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return stateManager.get(session.getId());
    }
}