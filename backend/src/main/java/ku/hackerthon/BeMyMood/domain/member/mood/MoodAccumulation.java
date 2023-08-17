package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class MoodAccumulation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mood_accumulation_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @OneToOne
    @JoinColumn(name = "mood_id")
    private Mood mood;

    private int accumulate;

    public MoodAccumulation(Member member, Mood mood) {
        this.member = member;
        this.mood = mood;
        this.accumulate = 1;
    }

    public boolean isMood(Mood mood) {
        return this.mood.equals(mood);
    }

    public void increase() {
        accumulate++;
    }
}
