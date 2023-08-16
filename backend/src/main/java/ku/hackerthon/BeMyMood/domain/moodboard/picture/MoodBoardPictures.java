package ku.hackerthon.BeMyMood.domain.moodboard.picture;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class MoodBoardPictures {
    @OneToMany(mappedBy = "moodBoard", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MoodBoardPicture> pictures = new ArrayList<>();

    // Method
    public void add(MoodBoardPicture boardPicture) {
        pictures.add(boardPicture);
    }

    public List<MoodBoardPicture> getAllPictures() { return this.pictures; }
}
