package ku.hackerthon.BeMyMood.domain.moodboard;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class MoodBoards {
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<MoodBoard> moodBoards = new ArrayList<>();

    // Method
    public void add(MoodBoard moodBoard) throws IllegalArgumentException {
        moodBoards.add(moodBoard);
    }
}
