package ku.hackerthon.BeMyMood.domain.member;

import ku.hackerthon.BeMyMood.domain.member.bookmark.Bookmark;
import ku.hackerthon.BeMyMood.domain.member.bookmark.Bookmarks;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocation;
import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.*;
import ku.hackerthon.BeMyMood.domain.mood.badge.Badge;
import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoards;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.domain.review.Reviews;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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
    private Reviews reviews;

    @Embedded
    private Bookmarks bookmarks;

    @Embedded
    private MoodBoards moodBoards;

    @Embedded
    private MoodAccumulations moodAccumulations;

    @Embedded
    private MemberBadges badges;

    // Constructor
    @Builder
    public Member(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.preferredMoods = new PreferredMoods();
        this.preferredLocations = new PreferredLocations();
        this.reviews = new Reviews();
        this.bookmarks = new Bookmarks();
        this.moodBoards = new MoodBoards();
        this.moodAccumulations = new MoodAccumulations();
        this.badges = new MemberBadges();
    }

    // Method
    public void addMood(PreferredMood preferredMood) {
        this.preferredMoods.add(preferredMood);
    }

    public boolean matchPassword(String password) {
        return this.password.equals(password);
    }

    public void addBookmark(Bookmark bookmark) { this.bookmarks.add(bookmark); }

    public void addMoodBoard(MoodBoard moodBoard) { this.moodBoards.add(moodBoard); }

    public void removeBookmark(Bookmark bookmark) { this.bookmarks.remove(bookmark); }

    public boolean bookmarked(Spot spot) {
        return bookmarks.hasSpot(spot);
    }

    public void addLocation(PreferredLocation location) {
        this.preferredLocations.add(location);
    }

    public void addReview(Review review) {
        this.reviews.add(review);
    }

    public boolean hasBadge(Badge badge) {
        return this.badges.has(badge);
    }

    public void addBadge(Badge badge) {
        if (hasBadge(badge)) {
            return;
        }
        this.badges.add(this, badge);
    }
}