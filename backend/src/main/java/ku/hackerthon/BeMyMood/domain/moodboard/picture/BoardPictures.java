package ku.hackerthon.BeMyMood.domain.moodboard.picture;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class BoardPictures {
    @OneToMany(mappedBy = "moodBoard", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BoardPicture> pictures = new ArrayList<>();

    public void add(BoardPicture boardPicture) {
        pictures.add(boardPicture);
    }
}
