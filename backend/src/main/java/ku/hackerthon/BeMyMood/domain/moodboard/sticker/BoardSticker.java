package ku.hackerthon.BeMyMood.domain.moodboard.sticker;

import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BoardSticker {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_sticker_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mood_board_id")
    private MoodBoard moodBoard;

    private Long stickerId;

    private Double locationX;

    private Double locationY;

    private Double width;

    private Double height;

    private Double rotation;

    // Constructor
    public BoardSticker(MoodBoard moodBoard) {
        this.moodBoard = moodBoard;
        moodBoard.addBoardStickers(this);
    }

}

// 고유 id / mood_board_id / (sticker)id / x y / h w / rotation
