package ku.hackerthon.BeMyMood.service.location;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.spot.Spot;

import java.util.Collection;
import java.util.List;

public interface LocationService {

    List<Location> searchAllContainsName(String subName);

    Location getByName(String name);
}
