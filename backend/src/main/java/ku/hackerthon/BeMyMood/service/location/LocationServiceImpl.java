package ku.hackerthon.BeMyMood.service.location;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.respository.LocationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class LocationServiceImpl implements LocationService {

    private final LocationRepository locationRepository;

    @Override
    public List<Location> searchAllContainsName(String subName) {
        return locationRepository.findContainsByName(subName);
    }

    @Override
    public Location getByName(String name) {
        return locationRepository.findByName(name);
    }
}
