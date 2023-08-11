package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.domain.spot.SpotCategory;
import ku.hackerthon.BeMyMood.respository.SpotRepository;
import ku.hackerthon.BeMyMood.service.location.LocationService;
import ku.hackerthon.BeMyMood.service.mood.MoodService;
import ku.hackerthon.BeMyMood.dto.spot.SpotSearchParams;
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
     * [ 카테고리 / 위치 / 무드 ]로 스팟 리스트를 검색
     * @param params -> 각 필드각 nullable
     */
    @Transactional
    @Override
    public List<Spot> searchAll(SpotSearchParams params) {

        List<Spot> collectByLocation = collectByLocation(params);
        List<Spot> collectByCategory = collectByCategory(collectByLocation, params);
        List<Spot> collectByMood = collectByMood(collectByCategory, params);
        return collectByMood;
    }

    @Override
    public List<Spot> recommend(PreferredLocations preferredLocations, PreferredMoods preferredMoods) {
        List<Spot> preferredSpots = spotRepository.findAllPreferLocated(preferredLocations);
        Map<Spot, Integer> spotScores = new HashMap<>();
        preferredSpots.stream()
                .forEach(spot -> {
                    int matched = spot.getSpotMoods().countMatchingMoods(preferredMoods);
                    spotScores.put(spot, matched);
                });

        return spotScores.entrySet().stream()
                .sorted(Map.Entry.comparingByValue(Comparator.reverseOrder()))
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    private List<Spot> collectByLocation(SpotSearchParams params) {
        if (params.getLocationName() != null) {
            Location location = locationService.getByName(params.getLocationName());
            return spotRepository.findAllLocatedIn(location);
        }
        return getAll();
    }

    private List<Spot> collectByCategory(List<Spot> spots, SpotSearchParams params) {
        if (params.getCategoryName() != null) {
            SpotCategory category = SpotCategory.ofName(params.getCategoryName());
            return spots.stream()
                    .filter(spot -> spot.getCategory().equals(category))
                    .collect(Collectors.toList());
        }

        return spots;
    }

    private List<Spot> collectByMood(List<Spot> spots,  SpotSearchParams params) {
        if (params.getMoodName() != null) {
            Mood mood = moodService.getByName(params.getMoodName());
            return spots.stream()
                    .filter(spot -> spot.hasMood(mood))
                    .collect(Collectors.toList());
        }

        return spots;
    }
}
