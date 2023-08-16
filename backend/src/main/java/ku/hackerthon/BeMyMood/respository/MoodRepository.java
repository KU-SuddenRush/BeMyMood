package ku.hackerthon.BeMyMood.respository;

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

    public Long save(Mood mood) {
        em.persist(mood);
        return mood.getId();
    }

    public Mood findByName(String name) {
        return em.createQuery("select m from Mood m where m.name = :name", Mood.class)
                .setParameter("name", name)
                .getSingleResult();
    }

    public List<Long> findAllColorIds() {
        return em.createQuery("select m.id from Mood m where m.type = :type", Long.class)
                .setParameter("type", MoodType.COLOR)
                .getResultList();
    }

    public List<Long> findAllVibeIds() {
        return em.createQuery("select m.id from Mood m where m.type = :type", Long.class)
                .setParameter("type", MoodType.VIBE)
                .getResultList();
    }

    public Mood findById(Long moodId) {
        return em.find(Mood.class, moodId);
    }
}
