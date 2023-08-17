package ku.hackerthon.BeMyMood.domain.spot.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SpotMood {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_mood_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "spot_id")
    private Spot spot;

    @ManyToOne
    @JoinColumn(name = "mood_id")
    private Mood mood;

    // Method
    public boolean isOf(Mood mood) {
        return this.mood.equals(mood);
    }
}
