package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.badge.Badge;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class MemberBadge {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_badge_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "badge_id")
    private Badge badge;

    // Constructor
    public MemberBadge(Member member, Badge badge) {
        this.member = member;
        this.badge = badge;
    }

    // Method
    public boolean isOf(Badge badge) {
        return this.badge.equals(badge);
    }
}
