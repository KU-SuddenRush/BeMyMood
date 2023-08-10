package ku.hackerthon.BeMyMood.domain.spot;

import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.spot.mood.SpotMood;
import ku.hackerthon.BeMyMood.service.spot.dto.SpotParams;
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

    private String introduce;

    @Enumerated(EnumType.STRING)
    private SpotCategory category;

    private LocalTime openAt;

    private LocalTime closeAt;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "location_id")
    private Location location;

    @OneToMany(mappedBy = "spot")
    private List<SpotMood> spotMoods = new ArrayList<>();


    @OneToMany(mappedBy = "spot")
    private List<Review> reviews = new ArrayList<>();

    // Constructor
    private Spot(String name, String introduce, SpotCategory category, Location location, LocalTime openAt, LocalTime closeAt) {
        this.name = name;
        this.introduce = introduce;
        this.category = category;
        this.location = location;
        this.openAt = openAt;
        this.closeAt = closeAt;
    }

    public static Spot ofParams(SpotParams params) {
        return new Spot(
                params.getName(),
                params.getIntroduce(),
                params.getCategory(),
                params.getLocation(),
                params.getOpenAt(),
                params.getCloseAt()
        );
    }


    public int countMatchingMoods(PreferredMoods preferredMoods) {
        return (int) spotMoods.stream()
                .filter(spotMood -> preferredMoods.hasMood(spotMood.getMood()))
                .count();
    }

    public boolean hasMood(Mood mood) {
        return spotMoods.stream()
                .map(SpotMood::getMood)
                .anyMatch(m -> m.equals(mood));
    }
}
