package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;

import javax.persistence.CascadeType;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

public class PreferredMoods {

    private static final int MAX_PREFERRED = 3;

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<PreferredMood> preferredMoods = new ArrayList<>();

    // Method
    public boolean isEmpty() {
        return this.preferredMoods.size() == 0;
    }

    public void add(PreferredMood preferredMood) throws IllegalArgumentException {
        preferredMoods.add(preferredMood);
    }

    public boolean hasMood(Mood mood) {
        return this.preferredMoods.stream()
                .anyMatch(pm -> pm.equalMood(mood));
    }

    public List<String> getNames() {
        List<String> names = new ArrayList<>();
        for (PreferredMood mood : this.preferredMoods) {
            names.add(mood.getMood().getName());
        }
        return names;
    }
}
