package ku.hackerthon.BeMyMood.dto.auth;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SignupParams {

    private String name;
    private String email;
    private String password;
}
