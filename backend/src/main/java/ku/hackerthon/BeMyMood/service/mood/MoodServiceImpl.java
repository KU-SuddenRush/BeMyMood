package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.respository.MoodRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MoodServiceImpl implements MoodService {

    private final MoodRepository moodRepository;

    @Override
    public Long register(Mood mood) { return moodRepository.save(mood); }

    @Override
    public Mood getByName(String name) {
        return moodRepository.findByName(name);
    }

    @Override
    public List<Long> getAllColors() { return moodRepository.findAllColorIds(); }

    @Override
    public List<Long> getAllVibes() { return moodRepository.findAllVibeIds(); }

    @Override
    public Mood getById(Long moodId) {
        return moodRepository.findById(moodId);
    }
}
