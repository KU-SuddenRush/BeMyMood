package ku.hackerthon.BeMyMood.domain.member.tag;

import ku.hackerthon.BeMyMood.domain.tag.Mood;
import ku.hackerthon.BeMyMood.domain.member.Member;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberMood {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_mood_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "mood_id")
    private Mood mood;
}
