package ku.hackerthon.BeMyMood.domain.review;

import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class PublicReviews {

    @OneToMany(mappedBy = "spot")
    private List<Review> publicReviews = new ArrayList<>();

    public void addReview(Review review) {
        publicReviews.add(review);
    }

    public List<Review> getPublicReviews() {
        return publicReviews;
    }
}
