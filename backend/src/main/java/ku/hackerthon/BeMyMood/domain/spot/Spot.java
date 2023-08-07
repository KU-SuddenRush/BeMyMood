package ku.hackerthon.BeMyMood.domain.spot;

import ku.hackerthon.BeMyMood.domain.spot.tag.SpotColor;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Spot {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_id")
    private Long id;

    @Column(name = "spot_name")
    private String name;

    @OneToMany(mappedBy = "spot")
    private List<SpotColor> spotColors = new ArrayList<>();

}
