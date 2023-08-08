package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;

@RequiredArgsConstructor
@Repository
public class SpotRepository {

    private final EntityManager em;

    public Long save(Spot spot) {
        em.persist(spot);
        return spot.getId();
    }

    public Spot findById(Long spotId) {
        return em.find(Spot.class, spotId);
    }
}
