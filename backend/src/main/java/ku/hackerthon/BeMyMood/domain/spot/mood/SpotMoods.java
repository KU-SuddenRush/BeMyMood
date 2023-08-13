package ku.hackerthon.BeMyMood.domain.spot.mood;

import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMood;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;

import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class SpotMoods {

    private static final int MAX_PREFERRED = 6;

    @OneToMany(mappedBy = "spot")
    private List<SpotMood> spotMoods = new ArrayList<>();

    // Method
    public boolean isEmpty() {
        return this.spotMoods.size() == 0;
    }

    public void add(SpotMood spotMood) throws IllegalArgumentException {
        if (spotMoods.size() >= MAX_PREFERRED) {
            throw new IllegalStateException("무드는 3개까지 저장 가능");
        }
        spotMoods.add(spotMood);
    }

    public boolean hasMood(Mood mood) {
        return this.spotMoods.stream()
                .anyMatch(sm ->sm.isOf(mood));
    }

    public boolean hasMoodIn(PreferredMoods preferredMoods) {
        return spotMoods.stream()
                .map(SpotMood::getMood)
                .anyMatch(preferredMoods::hasMood);
    }

    public int countMatchingMoods(PreferredMoods preferredMoods) {
        return (int) spotMoods.stream()
                .map(SpotMood::getMood)
                .filter(preferredMoods::hasMood)
                .count();
    }

    public List<String> getMoodNames() {
        List<String> names = new ArrayList<>();
        for (SpotMood mood : this.spotMoods) {
            names.add(mood.getMood().getName());
        }
        return names;
    }
}
