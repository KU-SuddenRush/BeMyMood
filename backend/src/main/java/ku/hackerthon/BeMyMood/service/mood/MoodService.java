package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;

import java.util.List;

public interface MoodService {

    Mood getByName(String name);

    List<String> getAllColors();

    List<String> getAllVibes();
}
