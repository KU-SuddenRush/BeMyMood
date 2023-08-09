package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.respository.SpotRepository;
import ku.hackerthon.BeMyMood.service.spot.dto.SpotParams;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class SpotServiceImpl implements SpotService {

    private final SpotRepository spotRepository;

    @Override
    public Spot register(SpotParams spotParams) {
        Spot spot = Spot.ofParams(spotParams);
        spotRepository.save(spot);
        return spot;
    }

    @Override
    public List<Spot> searchAllByMoods(List<Mood> moods) {
        return null;
    }
}
