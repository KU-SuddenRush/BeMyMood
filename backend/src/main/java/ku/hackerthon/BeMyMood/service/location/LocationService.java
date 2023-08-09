package ku.hackerthon.BeMyMood.service.location;

import ku.hackerthon.BeMyMood.domain.location.Location;

import java.util.List;

public interface LocationService {

    List<Location> searchAllContainsName(String subName);
}
