package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.dto.auth.SigninParams;
import ku.hackerthon.BeMyMood.dto.web.request.SigninRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.SigninResponseDto;
import ku.hackerthon.BeMyMood.service.auth.AuthService;
import ku.hackerthon.BeMyMood.dto.auth.SignupParams;
import ku.hackerthon.BeMyMood.dto.web.request.SignupRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.SignupResponseDto;
import ku.hackerthon.BeMyMood.service.auth.state.StateManager;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/auth")
@RestController
public class AuthController {

    private final AuthService authService;
    private final StateManager<String, Long> stateManager;

    /**
     * Member 회원 가입
     * @param requestDto
     * @return
     */
    @PostMapping("/signup")
    public ResponseEntity<SignupResponseDto> signup(
            @RequestBody SignupRequestDto requestDto,
            HttpServletRequest request
    ) {
        SignupResponseDto responseDto = authService.signup(new SignupParams(
                        requestDto.getName(), requestDto.getEmail(), requestDto.getPassword()
                )
        );

        storeState(request, responseDto.getMemberId());
        return ResponseEntity.ok(responseDto);
    }

    /**
     * Member 로그인
     * @param requestDto
     * @return
     */
    @PostMapping("/signin")
    public ResponseEntity<SigninResponseDto> signin(
            @RequestBody SigninRequestDto requestDto,
            HttpServletRequest request
    ) {
        SigninResponseDto responseDto = authService.signin(new SigninParams(
                        requestDto.getEmail(), requestDto.getPassword()
                )
        );

        storeState(request, responseDto.getMemberId());
        return ResponseEntity.ok(responseDto);
    }

    private void storeState(HttpServletRequest request, Long memberId) {
        stateManager.store(
                createSession(request).getId(),
                memberId
        );
    }

    private HttpSession createSession(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(0);
        return session;
    }
}
