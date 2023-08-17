package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.spot.SpotPublicReviewsInfo;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class SpotPublicReviewsResponseDto {
    private List<SpotPublicReviewsInfo> publicReviewsInfos;
}
