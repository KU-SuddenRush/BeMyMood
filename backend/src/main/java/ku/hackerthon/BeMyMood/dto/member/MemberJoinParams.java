package ku.hackerthon.BeMyMood.dto.member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberJoinParams {
    private String name;
    private String email;
    private String password;
}
