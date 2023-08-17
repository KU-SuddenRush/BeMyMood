package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.badge.Badge;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Repository
public class BadgeRepository {

    private final EntityManager em;

    public Badge findByMoodId(Long moodId) {
        return em.createQuery("select b from Badge b where b.mood.id = :id", Badge.class)
                .setParameter("id", moodId)
                .getSingleResult();
    }

    public List<Badge> findOpensByMemberId(Long memberId) {
        return em.createQuery("select mb.badge from MemberBadge mb where mb.member.id = :id", Badge.class)
                .setParameter("id", memberId)
                .getResultList();
    }

    public List<Badge> findAllLockedBy(Member member) {
        List<Badge> badges = em.createQuery("select b from Badge b", Badge.class)
                .getResultList();

        return badges.stream()
                .filter(badge -> !member.hasBadge(badge))
                .collect(Collectors.toList());
    }
}
