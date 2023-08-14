package ku.hackerthon.BeMyMood.dto.web.request;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalTime;
import java.util.List;

@Getter
@AllArgsConstructor
public class SpotCreateRequestDto {

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
