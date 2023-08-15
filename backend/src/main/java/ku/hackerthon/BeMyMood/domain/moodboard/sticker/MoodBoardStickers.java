package ku.hackerthon.BeMyMood.domain.moodboard.sticker;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class MoodBoardStickers {
    @OneToMany(mappedBy = "moodBoard", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MoodBoardSticker> stickers = new ArrayList<>();

    public void add(MoodBoardSticker boardSticker) {
        stickers.add(boardSticker);
    }
}
