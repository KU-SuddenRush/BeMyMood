package ku.hackerthon.BeMyMood.dto.member.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberMoodRequestDto {
    private List<String> moods;
}
