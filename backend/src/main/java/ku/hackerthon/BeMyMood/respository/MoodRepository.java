package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;

@RequiredArgsConstructor
@Repository
public class MoodRepository {

    private final EntityManager em;

    public Mood findByName(String name) {
        return em.createQuery("select m from Mood m where m.name = :name", Mood.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
