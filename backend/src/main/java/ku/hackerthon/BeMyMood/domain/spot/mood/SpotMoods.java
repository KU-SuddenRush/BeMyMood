package ku.hackerthon.BeMyMood.domain.spot.mood;

import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Embeddable
public class SpotMoods {

    private static final int MAX_PREFERRED = 6;

    @OneToMany(mappedBy = "spot", cascade = CascadeType.ALL)
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
        return spotMoods.stream()
                .map(spotMood -> spotMood.getMood().getName())
                .collect(Collectors.toList());
    }

    public List<Mood> getMoods() {
        return spotMoods.stream()
                .map(SpotMood::getMood)
                .collect(Collectors.toUnmodifiableList());
    }
}
