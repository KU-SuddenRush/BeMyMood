package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.service.spot.dto.SpotParams;

public interface SpotService {

    Spot register(SpotParams spotParams);
}
