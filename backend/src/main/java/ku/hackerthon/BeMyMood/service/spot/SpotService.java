package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.spot.SpotSearchParams;
import ku.hackerthon.BeMyMood.dto.spot.SpotParams;
import ku.hackerthon.BeMyMood.dto.web.response.RecommendedSpotsResponseDto;

import java.util.List;

public interface SpotService {

    Spot register(SpotParams spotParams);

    List<Spot> getAll();

    List<Spot> searchAll(SpotSearchParams spotSearchParams);

    RecommendedSpotsResponseDto recommend(PreferredLocations preferredLocations, PreferredMoods preferredMoods);
}
