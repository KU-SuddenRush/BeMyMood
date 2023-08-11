package ku.hackerthon.BeMyMood.domain.spot;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SpotImage {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_img_id")
    private Long id;

    @Column(name = "spot_img_url")
    private String imgUrl;

    @ManyToOne
    @JoinColumn(name = "spot_id")
    private Spot spot;
}
