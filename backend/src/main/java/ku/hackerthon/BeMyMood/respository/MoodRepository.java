package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.mood.MoodType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class MoodRepository {

    private final EntityManager em;

    public Mood findByName(String name) {
        return em.createQuery("select m from Mood m where m.name = :name", Mood.class)
                .setParameter("name", name)
                .getSingleResult();
    }

    public List<String> findAllColors() {
        return em.createQuery("select m.name from Mood m where m.type = :type", String.class)
                .setParameter("type", MoodType.COLOR)
                .getResultList();
    }

    public List<String> findAllVibes() {
        return em.createQuery("select m.name from Mood m where m.type = :type", String.class)
                .setParameter("type", MoodType.VIBE)
                .getResultList();
    }
}
