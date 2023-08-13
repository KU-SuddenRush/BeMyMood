package ku.hackerthon.BeMyMood.domain.member.bookmark;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Bookmark {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bookmark_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "spot_id")
    private Spot spot;

    // Constructor
    public Bookmark(Member member, Spot spot) {
        this.member = member;
        member.addBookmark(this);
        this.spot = spot;
    }

    // Method
    public boolean equalSpot(Spot spot) {
        return this.spot.equals(spot);
    }
}
