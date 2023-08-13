package ku.hackerthon.BeMyMood.domain.member;

import ku.hackerthon.BeMyMood.domain.member.bookmark.Bookmark;
import ku.hackerthon.BeMyMood.domain.member.bookmark.Bookmarks;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMood;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Member {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    @Column(name = "member_name")
    private String name;

    private String email;

    private String password;

    @Embedded
    private PreferredMoods preferredMoods;

    @Embedded
    private PreferredLocations preferredLocations;

    @Embedded
    private Bookmarks bookmarks;

    // Constructor
    @Builder
    public Member(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.preferredMoods = new PreferredMoods();
        this.preferredLocations = new PreferredLocations();
        this.bookmarks = new Bookmarks();
    }

    // Method
    public void addMood(PreferredMood preferredMood) {
        this.preferredMoods.add(preferredMood);
    }

    public boolean matchPassword(String password) {
        return this.password.equals(password);
    }

    public void addBookmark(Bookmark bookmark) { this.bookmarks.add(bookmark); }

    public void removeBookmark(Bookmark bookmark) { this.bookmarks.remove(bookmark); }

    public boolean bookmarked(Spot spot) {
        return bookmarks.hasSpot(spot);
    }
}