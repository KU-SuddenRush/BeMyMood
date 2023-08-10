package ku.hackerthon.BeMyMood.service.spot.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class SpotSearchParams {

    private String categoryName;
    private String locationName;
    private String moodName;
}
