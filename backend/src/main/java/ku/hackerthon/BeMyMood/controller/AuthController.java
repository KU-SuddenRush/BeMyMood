package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.dto.auth.SigninParams;
import ku.hackerthon.BeMyMood.dto.web.request.SigninRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.SigninResponseDto;
import ku.hackerthon.BeMyMood.service.auth.AuthService;
import ku.hackerthon.BeMyMood.dto.auth.SignupParams;
import ku.hackerthon.BeMyMood.dto.web.request.SignupRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.SignupResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/auth")
@RestController
public class AuthController {

    private final AuthService authService;

    /**
     * Member 회원 가입
     * @param requestDto
     * @return
     */
    @PostMapping("/signup")
    public ResponseEntity<SignupResponseDto> signup(@RequestBody SignupRequestDto requestDto) {
        SignupResponseDto response = authService.signup(new SignupParams(
                        requestDto.getName(), requestDto.getEmail(), requestDto.getPassword()
                )
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Member 로그인
     * @param requestDto
     * @return
     */
    @PostMapping("/signin")
    public ResponseEntity<SigninResponseDto> signin(@RequestBody SigninRequestDto requestDto) {
        SigninResponseDto responseDto = authService.signin(new SigninParams(
                        requestDto.getEmail(), requestDto.getPassword()
                )
        );
        return ResponseEntity.ok(responseDto);
    }
}
