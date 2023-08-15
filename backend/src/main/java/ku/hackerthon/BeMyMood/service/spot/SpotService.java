package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.spot.SpotFilterParams;
import ku.hackerthon.BeMyMood.dto.web.request.SpotCreateRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SpotService {

    Long register(SpotCreateRequestDto requestDto);

    List<Spot> getAll();

    AllSpotInfoResponseDto getAllInfo();

    Spot searchById(Long spotId);

    FilteredSpotsResponseDto filter(SpotFilterParams params);

    SpotDetailsResponseDto getSpotDetails(Spot spot, Member member);

    RecommendedSpotsResponseDto recommend(PreferredLocations preferredLocations, PreferredMoods preferredMoods);

    void registerImages(Long spotId, List<MultipartFile> files);

    SpotPublicReviewsResponseDto getSpotReviews(Spot spot);
}
