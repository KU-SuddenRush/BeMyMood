package ku.hackerthon.BeMyMood.domain.member.location;

import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class PreferredLocations {

    private static final int MAX_PREFERRED = 3;

    @OneToMany(mappedBy = "member")
    private List<PreferredLocation> preferredLocations = new ArrayList<>();

    // Method
    public boolean isEmpty() {
        return this.preferredLocations.size() == 0;
    }

    public void add(PreferredLocation location) throws IllegalArgumentException {
        if (preferredLocations.size() >= MAX_PREFERRED) {
            throw new IllegalStateException("선호 위치는 3개까지 저장 가능");
        }
        preferredLocations.add(location);
    }
}
