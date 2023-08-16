package ku.hackerthon.BeMyMood.domain.moodboard;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.*;

@Embeddable
public class MoodBoards {
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<MoodBoard> moodBoards = new ArrayList<>();

    // Method
    public void add(MoodBoard moodBoard) throws IllegalArgumentException {
        moodBoards.add(moodBoard);
    }

    public List<MoodBoard> getAllMoodBoards() {
        return Collections.unmodifiableList(moodBoards);
    }

    public MoodBoard getLastEditedMoodBoard() {
        return moodBoards.stream()
                .sorted(Comparator.comparing(MoodBoard::getUpdatedAt).reversed())
                .findFirst().orElseThrow(() -> new NullPointerException("무드보드가 존재하지 않습니다."));
    }

}
