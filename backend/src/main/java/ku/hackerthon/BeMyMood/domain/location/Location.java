package ku.hackerthon.BeMyMood.domain.location;

import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@EqualsAndHashCode(of = {"name"})
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Location {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "location_id")
    private Long id;

    @Column(name = "location_name")
    private String name;

    // Constructor
    private Location(String name) {
        this.name = name;
    }

    // Method
    public static Location of(String name) {
        return new Location(name);
    }
}