package ku.hackerthon.BeMyMood.dto.spot;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalTime;
import java.util.List;

@Getter
@Builder
@AllArgsConstructor
public class SpotParams {

    private String name;
    private String address;
    private Long locationId;
    private String contact;
    private String introduce;
    private String categoryName;
    private LocalTime openAt;
    private LocalTime closeAt;
    private List<Long> moodIds;
}
