package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;

import javax.persistence.CascadeType;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

public class PreferredMoods {

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PreferredMood> preferredMoods = new ArrayList<>();

    // Method
    public boolean isEmpty() {
        return this.preferredMoods.size() == 0;
    }

    public void clearPreferredMoods() {
        preferredMoods.clear();
    }

    public void add(PreferredMood preferredMood) throws IllegalArgumentException {
        preferredMoods.add(preferredMood);
    }

    public boolean hasMood(Mood mood) {
        return this.preferredMoods.stream()
                .anyMatch(pm -> pm.equalMood(mood));
    }

    public List<Long> getIds() {
        List<Long> ids = new ArrayList<>();
        for (PreferredMood mood : this.preferredMoods) {
            ids.add(mood.getMood().getId());
        }
        return ids;
    }
}
