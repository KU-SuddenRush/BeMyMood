package ku.hackerthon.BeMyMood.domain.moodboard.sticker;

import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

@Embeddable
public class BoardStickers {
    @OneToMany(mappedBy = "moodBoard", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BoardSticker> stickers = new ArrayList<>();

    public void add(BoardSticker boardSticker) {
        stickers.add(boardSticker);
    }
}
