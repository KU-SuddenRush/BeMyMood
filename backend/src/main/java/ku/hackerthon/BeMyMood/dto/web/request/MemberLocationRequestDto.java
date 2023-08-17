package ku.hackerthon.BeMyMood.dto.web.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class MemberLocationRequestDto {

    private List<Long> locationIds;
}
