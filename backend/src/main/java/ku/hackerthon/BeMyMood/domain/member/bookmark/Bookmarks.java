package ku.hackerthon.BeMyMood.domain.member.bookmark;

import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMood;
import ku.hackerthon.BeMyMood.domain.spot.Spot;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class Bookmarks {
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<Bookmark> bookmarks = new ArrayList<>();

    // Method
    public void add(Bookmark bookmark) throws IllegalArgumentException {
        bookmarks.add(bookmark);
    }

    public boolean hasSpot(Spot spot) {
        return this.bookmarks.stream()
                .anyMatch(bm -> bm.equalSpot(spot));
    }

    public List<Spot> getSpots() {
        List<Spot> spots = new ArrayList<>();
        for (Bookmark bookmark : this.bookmarks) {
            spots.add(bookmark.getSpot());
        }
        return spots;
    }
}
