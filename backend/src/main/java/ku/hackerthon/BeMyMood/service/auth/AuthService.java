package ku.hackerthon.BeMyMood.service.auth;

import ku.hackerthon.BeMyMood.dto.auth.SigninParams;
import ku.hackerthon.BeMyMood.dto.auth.SignupParams;
import ku.hackerthon.BeMyMood.dto.web.response.SigninResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.SignupResponseDto;

public interface AuthService {

    SignupResponseDto signup(SignupParams params);

    SigninResponseDto signin(SigninParams signinParams);
}
