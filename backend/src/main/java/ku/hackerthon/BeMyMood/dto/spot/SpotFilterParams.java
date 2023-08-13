package ku.hackerthon.BeMyMood.dto.spot;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SpotFilterParams {

    private Long categoryId;
    private Long locationId;
    private Long moodId;
}
