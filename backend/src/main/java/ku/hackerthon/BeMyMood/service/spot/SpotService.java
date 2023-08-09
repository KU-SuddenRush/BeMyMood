package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.service.spot.dto.SpotParams;

import java.util.List;

public interface SpotService {

    Spot register(SpotParams spotParams);

    List<Spot> searchAllByMoods(List<Mood> moods);
}
