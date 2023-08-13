package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.spot.SpotInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class AllSpotInfoResponseDto {

    private List<SpotInfo> spotInfos;
}
