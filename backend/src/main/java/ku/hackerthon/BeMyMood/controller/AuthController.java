package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.service.auth.AuthService;
import ku.hackerthon.BeMyMood.dto.auth.SignupParams;
import ku.hackerthon.BeMyMood.dto.web.request.MemberSignupRequestDto;
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

    @PostMapping("/signup")
    public ResponseEntity<SignupResponseDto> signup(@RequestBody MemberSignupRequestDto requestDto) {
        SignupResponseDto response = authService.signup(new SignupParams(
                requestDto.getName(), requestDto.getEmail(), requestDto.getPassword()
        ));

        return ResponseEntity.ok(response);
    }
}
