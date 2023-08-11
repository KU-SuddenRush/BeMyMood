package ku.hackerthon.BeMyMood.dto.web.request;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MemberInfoResponseDto {

    private Long memberId;
    private String name;
    private String email;
}
