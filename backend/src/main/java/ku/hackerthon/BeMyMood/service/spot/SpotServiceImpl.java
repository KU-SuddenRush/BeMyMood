package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.domain.spot.SpotCategory;
import ku.hackerthon.BeMyMood.dto.spot.FilteredSpotInfo;
import ku.hackerthon.BeMyMood.dto.spot.RecommendedSpotInfo;
import ku.hackerthon.BeMyMood.dto.web.response.FilteredSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.RecommendedSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.SpotDetailsResponseDto;
import ku.hackerthon.BeMyMood.respository.SpotRepository;
import ku.hackerthon.BeMyMood.service.location.LocationService;
import ku.hackerthon.BeMyMood.service.mood.MoodService;
import ku.hackerthon.BeMyMood.dto.spot.SpotFilterParams;
import ku.hackerthon.BeMyMood.dto.spot.SpotParams;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class SpotServiceImpl implements SpotService {

    private final SpotRepository spotRepository;
    private final LocationService locationService;
    private final MoodService moodService;

    /**
     * 새로운 스팟을 등록
     */
    @Override
    public Spot register(SpotParams spotParams) {
        Spot spot = Spot.ofParams(spotParams);
        spotRepository.save(spot);
        return spot;
    }

    /**
     * 등록된 모든 스팟을 검색
     */
    @Override
    public List<Spot> getAll() {
        return spotRepository.findAll();
    }

    /**
     * <b>spot의 id로 스팟 조회</b>
     * @param spotId
     * @return
     */
    @Override
    public Spot searchById(Long spotId) {
        return spotRepository.findById(spotId)
                .orElseThrow(() -> new IllegalArgumentException("wrong spot id"));
    }

    /**
     * [ 카테고리 / 위치 / 무드 ]로 스팟 리스트를 검색
     * @param params -> 각 필드각 nullable
     */
    @Transactional
    @Override
    public FilteredSpotsResponseDto filter(SpotFilterParams params) {

        List<Spot> collectByLocation = collectByLocation(params);
        List<Spot> collectByCategory = collectByCategory(collectByLocation, params);
        List<Spot> collectByMood = collectByMood(collectByCategory, params);

        return new FilteredSpotsResponseDto(
                collectByMood.stream()
                        .map(spot -> new FilteredSpotInfo(
                                spot.getId(),
                                spot.getName(),
                                spot.getSpotImages().getMainImage().getImgUrl(),
                                spot.getCategory().name(),
                                spot.getSpotMoods().getMoodNames()
                        )).collect(Collectors.toList())
        );
    }

    @Override
    public SpotDetailsResponseDto getSpotDetails(Spot spot, Member member) {
        return new SpotDetailsResponseDto(
                spot.getId(),
                member.bookmarked(spot),
                spot.getCategory().name(),
                spot.getName(),
                spot.getSpotMoods().getMoodNames(),
                spot.getSpotImages().getImageUrls(),
                spot.getAddress(),
                spot.getContact(),
                spot.getOperationInfo(),
                spot.getIntroduce()
        );
    }

    @Override
    public RecommendedSpotsResponseDto recommend(PreferredLocations preferredLocations, PreferredMoods preferredMoods) {

        List<Spot> preferredSpots = spotRepository.findAllPreferLocated(preferredLocations);
        Map<Spot, Integer> spotScores = new HashMap<>();
        preferredSpots.stream()
                .forEach(spot -> {
                    int matched = spot.getSpotMoods().countMatchingMoods(preferredMoods);
                    spotScores.put(spot, matched);
                });

        List<Spot> spotsOrderedByScore = spotScores.entrySet().stream()
                .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        return new RecommendedSpotsResponseDto(
                spotsOrderedByScore.stream()
                        .map(spot -> new RecommendedSpotInfo(
                                        spot.getId(),
                                        spot.getName(),
                                        spot.getSpotImages().getMainImage().getImgUrl(),
                                        spot.getCategory().name(),
                                        spot.getSpotMoods().getMoodNames()
                                )
                        ).collect(Collectors.toList())
        );
    }

    private List<Spot> collectByLocation(SpotFilterParams params) {
        if (params.getLocationName() != null) {
            Location location = locationService.getByName(params.getLocationName());
            return spotRepository.findAllLocatedIn(location);
        }
        return getAll();
    }

    private List<Spot> collectByCategory(List<Spot> spots, SpotFilterParams params) {
        if (params.getCategoryName() != null) {
            SpotCategory category = SpotCategory.ofName(params.getCategoryName());
            return spots.stream()
                    .filter(spot -> spot.getCategory().equals(category))
                    .collect(Collectors.toList());
        }

        return spots;
    }

    private List<Spot> collectByMood(List<Spot> spots,  SpotFilterParams params) {
        if (params.getMoodName() != null) {
            Mood mood = moodService.getByName(params.getMoodName());
            return spots.stream()
                    .filter(spot -> spot.hasMood(mood))
                    .collect(Collectors.toList());
        }

        return spots;
    }
}
