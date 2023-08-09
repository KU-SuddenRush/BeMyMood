package ku.hackerthon.BeMyMood.domain.spot.tag;

import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.domain.tag.Mood;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;

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
}
