package ku.hackerthon.BeMyMood.domain.review;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Embeddable
public class ReviewImages {
    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL)
    private List<ReviewImage> reviewImages = new ArrayList<>();

    // Method
    public void add(ReviewImage image) {
        reviewImages.add(image);
    }

    // Getter
    public List<String> getImageUrls() {
        return reviewImages.stream()
                .map(ReviewImage::getImgUrl)
                .collect(Collectors.toList());
    }
}
