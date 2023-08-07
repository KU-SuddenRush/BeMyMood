package ku.hackerthon.BeMyMood.domain.spot.tag;

import ku.hackerthon.BeMyMood.domain.tag.Color;
import ku.hackerthon.BeMyMood.domain.spot.Spot;

import javax.persistence.*;


@Entity
public class SpotColor {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_color_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "spot_id")
    private Spot spot;

    @ManyToOne
    @JoinColumn(name = "color_id")
    private Color color;
}
