package ku.hackerthon.BeMyMood.domain.member.location;

import ku.hackerthon.BeMyMood.domain.location.Location;
import ku.hackerthon.BeMyMood.domain.member.Member;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PreferredLocation {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "preferred_location_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "location_id")
    private Location location;

    // Constructor
    public PreferredLocation(Member member, Location location) {
        this.member = member;
        this.location = location;
    }
}