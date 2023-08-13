package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Repository
public class SpotRepository {

    private final EntityManager em;

    public Long save(Spot spot) {
        em.persist(spot);
        return spot.getId();
    }

    public List<Spot> findAllPreferLocated(PreferredLocations preferredLocations) {
        System.out.println(preferredLocations.getLocationIds());
        return em.createQuery("select s from Spot s where s.id in :locationIds", Spot.class)
                .setParameter("locationIds", preferredLocations.getLocationIds())
                .getResultStream()
                .collect(Collectors.toList());
    }

    public List<Spot> findAllLocatedIn(Location location) {
        return em.createQuery("select s from Spot s where s.location = :location", Spot.class)
                .setParameter("location", location)
                .getResultList();
    }

    public List<Spot> findAll() {
        return em.createQuery("select s from Spot s", Spot.class)
                .getResultList();
    }

    public Optional<Spot> findById(Long spotId) {
        return Optional.ofNullable(em.find(Spot.class, spotId));
    }
}
