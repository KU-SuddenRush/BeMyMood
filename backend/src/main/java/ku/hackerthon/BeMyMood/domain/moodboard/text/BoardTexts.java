package ku.hackerthon.BeMyMood.domain.moodboard.text;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class BoardTexts {
    @OneToMany(mappedBy = "moodBoard", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BoardText> texts = new ArrayList<>();

    public void add(BoardText boardText) {
        texts.add(boardText);
    }
}
