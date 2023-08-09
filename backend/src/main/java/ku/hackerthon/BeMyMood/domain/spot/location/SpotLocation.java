package ku.hackerthon.BeMyMood.domain.spot.location;

import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.domain.spot.location.Location;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SpotLocation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_location_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "spot_id")
    private Spot spot;

    @ManyToOne
    @JoinColumn(name = "location_id")
    private Location location;
}