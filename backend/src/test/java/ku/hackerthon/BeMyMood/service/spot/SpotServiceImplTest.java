package ku.hackerthon.BeMyMood.service.spot;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.domain.spot.SpotCategory;
import ku.hackerthon.BeMyMood.dto.spot.SpotParams;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import java.time.LocalTime;

import static org.assertj.core.api.Assertions.*;

@Transactional
@SpringBootTest
class SpotServiceImplTest {

    @Autowired
    private EntityManager em;

    @Autowired
    private SpotService spotService;

//    @Test
//    @DisplayName("Spot 저장 후 DB에서 조회해 동등성 비교")
//    void spot_register_test() {
//        // given
//        SpotParams spotParams = SpotParams.builder()
//                .name("spot")
//                .introduce("introduce")
//                .openAt(LocalTime.of(9, 0))
//                .closeAt(LocalTime.of(21, 0))
//                .location(Location.of("성수동"))
//                .category(SpotCategory.CAFE)
//                .build();
//
//        // when
//        Spot registeredSpot = spotService.register(spotParams);
//        Spot findSpot = (Spot) em.createQuery("select s from Spot s where s.name = :name")
//                .setParameter("name", spotParams.getName())
//                .getSingleResult();
//
//        // then
//        assertThat(registeredSpot).isEqualTo(findSpot);
//    }
}