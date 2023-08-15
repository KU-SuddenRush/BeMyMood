package ku.hackerthon.BeMyMood.domain.moodboard.text;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class MoodBoardTexts {
    @OneToMany(mappedBy = "moodBoard", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MoodBoardText> texts = new ArrayList<>();

    public void add(MoodBoardText boardText) {
        texts.add(boardText);
    }
}
