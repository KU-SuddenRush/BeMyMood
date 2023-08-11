package ku.hackerthon.BeMyMood.dto.spot;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class SpotSearchParams {

    private String categoryName;
    private String locationName;
    private String moodName;
}
