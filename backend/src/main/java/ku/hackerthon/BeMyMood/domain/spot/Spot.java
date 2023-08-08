package ku.hackerthon.BeMyMood.domain.spot;

import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.domain.spot.tag.SpotColor;
import ku.hackerthon.BeMyMood.domain.spot.tag.SpotLocation;
import ku.hackerthon.BeMyMood.domain.spot.tag.SpotMood;
import ku.hackerthon.BeMyMood.domain.tag.Location;
import ku.hackerthon.BeMyMood.service.spot.dto.SpotParams;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Spot {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_id")
    private Long id;

    @Column(name = "spot_name")
    private String name;

    private String introduce;

    private String category;

    private LocalTime openAt;

    private LocalTime closeAt;

    @OneToOne
    @JoinColumn(name = "location_id")
    private Location location;

    @OneToMany(mappedBy = "spot")
    private List<SpotColor> spotColors = new ArrayList<>();

    @OneToMany(mappedBy = "spot")
    private List<SpotMood> spotMoods = new ArrayList<>();


    @OneToMany(mappedBy = "spot")
    private List<Review> reviews = new ArrayList<>();

    // Constructor
    private Spot(String name, String introduce, String category, Location location, LocalTime openAt, LocalTime closeAt) {
        this.name = name;
        this.introduce = introduce;
        this.category = category;
        this.location = location;
        this.openAt = openAt;
        this.closeAt = closeAt;
    }

    // Method
    public static Spot of(SpotParams params) {
        return new Spot(
                params.getName(),
                params.getIntroduce(),
                params.getCategory(),
                params.getLocation(),
                params.getOpenAt(),
                params.getCloseAt()
        );
    }
}
