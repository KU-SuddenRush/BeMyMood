package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.respository.MoodRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MoodServiceImpl implements MoodService {

    private final MoodRepository moodRepository;

    @Override
    public Mood getByName(String name) {
        return moodRepository.findByName(name);
    }
}
