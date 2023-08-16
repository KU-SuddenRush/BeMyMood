package ku.hackerthon.BeMyMood.domain.member;

import ku.hackerthon.BeMyMood.domain.member.mood.MemberBadge;
import ku.hackerthon.BeMyMood.domain.mood.badge.Badge;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.List;
import java.util.stream.Collectors;

@Embeddable
public class MemberBadges {

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<MemberBadge> badges;

    public boolean has(Badge badge) {
        return badges.stream()
                .anyMatch(memberBadge -> memberBadge.isOf(badge));
    }

    public void add(Member member, Badge badge) {
        MemberBadge memberBadge = new MemberBadge(member, badge);
        badges.add(memberBadge);
    }

    public List<Badge> getBadges() {
        return badges.stream()
                .map(MemberBadge::getBadge)
                .collect(Collectors.toList());
    }
}
