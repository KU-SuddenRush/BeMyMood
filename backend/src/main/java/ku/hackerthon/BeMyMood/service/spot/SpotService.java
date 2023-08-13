package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.spot.SpotFilterParams;
import ku.hackerthon.BeMyMood.dto.spot.SpotParams;
import ku.hackerthon.BeMyMood.dto.web.response.AllSpotInfoResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.FilteredSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.RecommendedSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.SpotDetailsResponseDto;

import java.util.List;

public interface SpotService {

    Spot register(SpotParams spotParams);

    List<Spot> getAll();

    AllSpotInfoResponseDto getAllInfo();

    Spot searchById(Long spotId);

    FilteredSpotsResponseDto filter(SpotFilterParams params);

    SpotDetailsResponseDto getSpotDetails(Spot spot, Member member);

    RecommendedSpotsResponseDto recommend(PreferredLocations preferredLocations, PreferredMoods preferredMoods);
}
