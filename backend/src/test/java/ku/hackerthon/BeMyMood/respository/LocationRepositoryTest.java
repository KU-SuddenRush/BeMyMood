package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.location.Location;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.List;

import static org.assertj.core.api.Assertions.*;

@Transactional
@SpringBootTest
class LocationRepositoryTest {

    @Autowired
    EntityManager em;

    @Autowired
    LocationRepository locationRepository;

    @Test
    @DisplayName("새 위치 DB에 저장 후 정상 조회")
    void find_by_name() {
        // given
        String locationFullName = "방이동";
        Location newLocation = Location.of(locationFullName);

        String searchName = "방이";

        // when
        em.persist(newLocation);
        List<Location> locations = locationRepository.findContainsByName(searchName);

        // then
        assertThat(locations.size()).isEqualTo(1);
        assertThat(newLocation).isEqualTo(locations.get(0));
    }

    @Test
    @DisplayName("검색 결과가 없는 경우 결과 List size는 0")
    void find_by_noo_existing_name() {
        // given
        String searchName = "방이";

        // when
        List<Location> locations = locationRepository.findContainsByName(searchName);

        // then
        assertThat(locations.size()).isEqualTo(0);
    }
}