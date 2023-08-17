package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;

import java.util.List;

public interface MoodService {

    Long register(Mood mood);

    Mood getByName(String name);

    List<Long> getAllColors();

    List<Long> getAllVibes();

    Mood getById(Long moodId);
}
