package ku.hackerthon.BeMyMood.domain.review;

import ku.hackerthon.BeMyMood.domain.spot.Spot;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Embeddable
public class Reviews {

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<Review> reviews = new ArrayList<>();

    // Method
    public void add(Review review) {
        this.reviews.add(review);
    }

    public List<Review> getAllReview() {
        return Collections.unmodifiableList(reviews);
    }

    public Review getReviewBySpot(Spot spot) {
        return reviews.stream()
                .filter(review -> review.equalSpot(spot))
                .findFirst().get();
    }
}
