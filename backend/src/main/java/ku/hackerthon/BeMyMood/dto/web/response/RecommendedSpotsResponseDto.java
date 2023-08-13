package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.spot.RecommendedSpotInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class RecommendedSpotsResponseDto {

    private List<RecommendedSpotInfo> spotInfos;
}
