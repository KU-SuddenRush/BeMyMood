package ku.hackerthon.BeMyMood.service.spot.dto;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.spot.SpotCategory;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalTime;

@Getter
@Builder
@AllArgsConstructor
public class SpotParams {
    private String name;
    private String introduce;
    private SpotCategory category;
    private LocalTime openAt;
    private LocalTime closeAt;
    private Location location;
}
