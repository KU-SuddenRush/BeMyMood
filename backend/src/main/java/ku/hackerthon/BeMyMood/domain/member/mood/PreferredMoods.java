package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;

import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

public class PreferredMoods {

    private static final int MAX_PREFERRED = 3;

    @OneToMany(mappedBy = "member")
    private List<PreferredMood> preferredMoods = new ArrayList<>();

    // Method
    public boolean isEmpty() {
        return this.preferredMoods.size() == 0;
    }

    public void add(PreferredMood preferredMood) throws IllegalArgumentException {
        if (preferredMoods.size() >= MAX_PREFERRED) {
            throw new IllegalStateException("선호 위치는 3개까지 저장 가능");
        }
        preferredMoods.add(preferredMood);
    }

    public boolean hasMood(Mood mood) {
        return this.preferredMoods.stream()
                .anyMatch(pm -> pm.equalMood(mood));
    }
}
