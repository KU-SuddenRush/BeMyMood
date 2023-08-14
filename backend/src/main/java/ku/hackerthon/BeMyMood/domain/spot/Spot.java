package ku.hackerthon.BeMyMood.domain.spot;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.spot.mood.SpotMoods;
import ku.hackerthon.BeMyMood.dto.spot.SpotParams;
import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@EqualsAndHashCode(of = {"name", "location"})
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Spot {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spot_id")
    private Long id;

    @Column(name = "spot_name")
    private String name;

    private String address;

    private String contact;

    private String introduce;

    @Enumerated(EnumType.STRING)
    private SpotCategory category;

    private LocalTime openAt;

    private LocalTime closeAt;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "location_id")
    private Location location;

    @Embedded
    private SpotMoods spotMoods = new SpotMoods();

    @Embedded
    private SpotImages spotImages = new SpotImages();

    @OneToMany(mappedBy = "spot")
    private List<Review> reviews = new ArrayList<>();

    // Constructor
    public Spot(String name, String address, String contact, String introduce, SpotCategory category, Location location, LocalTime openAt, LocalTime closeAt) {
        this.name = name;
        this.address = address;
        this.contact = contact;
        this.introduce = introduce;
        this.category = category;
        this.location = location;
        this.openAt = openAt;
        this.closeAt = closeAt;
    }

    public boolean hasMood(Mood mood) {
        return spotMoods.hasMood(mood);
    }

    public String getOperationInfo() {
        return String.format("매일 %s - %s, 라스트오더 20:00", this.openAt.toString(), this.closeAt.toString());
    }
}
