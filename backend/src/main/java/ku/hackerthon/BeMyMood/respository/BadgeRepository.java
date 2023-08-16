package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.badge.Badge;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.Collection;
import java.util.List;

@RequiredArgsConstructor
@Repository
public class BadgeRepository {

    private final EntityManager em;

    public Badge findByMoodId(Long moodId) {
        return em.createQuery("select b from Badge b where b.mood.id = :id", Badge.class)
                .setParameter("id", moodId)
                .getSingleResult();
    }

    public List<Badge> findAllByMemberId(Long memberId) {
        return em.createQuery("select mb.badge from MemberBadge mb where mb.member.id = :id", Badge.class)
                .setParameter("id", memberId)
                .getResultList();
    }

    public List<Badge> findAllLockedBy(Member member) {
        return null;
    }
}
