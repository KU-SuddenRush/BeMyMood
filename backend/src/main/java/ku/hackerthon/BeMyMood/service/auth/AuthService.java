package ku.hackerthon.BeMyMood.service.auth;

import ku.hackerthon.BeMyMood.dto.auth.SignupParams;
import ku.hackerthon.BeMyMood.dto.web.response.SignupResponseDto;

public interface AuthService {

    public SignupResponseDto signup(SignupParams params);
}
