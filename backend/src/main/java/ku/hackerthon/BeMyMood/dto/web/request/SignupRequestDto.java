package ku.hackerthon.BeMyMood.dto.web.request;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class SignupRequestDto {

    private String name;
    private String email;
    private String password;
}
