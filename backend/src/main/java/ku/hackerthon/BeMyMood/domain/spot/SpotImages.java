package ku.hackerthon.BeMyMood.domain.spot;

import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Embeddable
public class SpotImages {

    @OneToMany(mappedBy = "spot")
    private List<SpotImage> spotImages = new ArrayList<>();

    // Getter
    public SpotImage getMainImage() {
        return spotImages.get(0);
    }

    public List<String> getImageUrls() {
        return spotImages.stream()
                .map(SpotImage::getImgUrl)
                .collect(Collectors.toList());
    }
}
