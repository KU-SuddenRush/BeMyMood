package ku.hackerthon.BeMyMood.domain.spot;

import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class SpotImages {

    @OneToMany(mappedBy = "spot")
    private List<SpotImage> spotImages = new ArrayList<>();

    // Method
    public SpotImage getThumbnail() {
        return spotImages.get(0);
    }
}
