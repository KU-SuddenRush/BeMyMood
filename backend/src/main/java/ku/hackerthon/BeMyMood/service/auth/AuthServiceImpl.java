package ku.hackerthon.BeMyMood.service.auth;

import ku.hackerthon.BeMyMood.dto.auth.SignupParams;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
import ku.hackerthon.BeMyMood.dto.web.response.SignupResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AuthServiceImpl implements AuthService {

    private final MemberService memberService;

    @Override
    public SignupResponseDto signup(SignupParams params) {
        Long joinMemberId = memberService.join(new MemberJoinParams(
                        params.getName(), params.getEmail(), params.getPassword()
                )
        );

        return new SignupResponseDto(joinMemberId);
    }
}
