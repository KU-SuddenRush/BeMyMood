package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;

public interface MoodService {

    Mood getByName(String name);
}
