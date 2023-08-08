package ku.hackerthon.BeMyMood.service.spot.dto;

import ku.hackerthon.BeMyMood.domain.tag.Location;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalTime;

@Getter
@AllArgsConstructor
public class SpotParams {
    private String name;
    private String introduce;
    private String category;
    private LocalTime openAt;
    private LocalTime closeAt;
    private Location location;
}
