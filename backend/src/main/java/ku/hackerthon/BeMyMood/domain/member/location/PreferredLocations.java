package ku.hackerthon.BeMyMood.domain.member.location;

import ku.hackerthon.BeMyMood.domain.location.Location;

import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Embeddable
public class PreferredLocations {

    private static final int MAX_PREFERRED = 3;
    private static int orderSequence = 1;

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

    public List<Long> getLocationIds() {
        return preferredLocations.stream()
                .map(PreferredLocation::getLocation)
                .map(Location::getId)
                .collect(Collectors.toUnmodifiableList());
    }

    public List<String> getNames() {
        return this.preferredLocations.stream()
                .map(preferredLocation -> preferredLocation.getLocation().getName())
                .collect(Collectors.toList());
    }
}
