package ku.hackerthon.BeMyMood.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SigninParams {

    private String email;
    private String password;
}
