package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PreferredMood {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_mood_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "mood_id")
    private Mood mood;

    // Constructor
    public PreferredMood(Member member, Mood mood) {
        this.member = member;
        member.addMood(this);
        this.mood = mood;
    }

    // Method
    public boolean equalMood(Mood mood) {
        return this.mood.equals(mood);
    }
}
