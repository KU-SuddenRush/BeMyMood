package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.location.Location;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class LocationRepository {

    private final EntityManager em;

    public List<Location> findContainsByName(String name) {
        return em.createQuery("select l from Location l where l.name like :name", Location.class)
                .setParameter("name", "%" + name + "%")
                .getResultList();
    }

    public Location findByName(String name) {
        return em.createQuery("select l from Location l where l.name = :name", Location.class)
                .setParameter("name", name)
                .getSingleResult();
    }

    public Location findById(Long locationId) {
        return em.find(Location.class, locationId);
    }
}
