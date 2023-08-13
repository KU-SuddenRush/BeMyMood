package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.spot.FilteredSpotInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class FilteredSpotsResponseDto {

    private List<FilteredSpotInfo> spotInfos;
}
