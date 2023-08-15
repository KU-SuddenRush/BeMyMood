package ku.hackerthon.BeMyMood.domain.moodboard.text;

import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MoodBoardText {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_text_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mood_board_id")
    private MoodBoard moodBoard;

    private Double locationX;

    private Double locationY;

    private Long fontSize;

    private int fontColor;

    private int sort;

    private String contents;

    // Constructor
    public MoodBoardText(MoodBoard moodBoard, Double locationX, Double locationY, Long fontSize, int fontColor, int sort, String contents) {
        this.locationX = locationX;
        this.locationY = locationY;
        this.fontSize = fontSize;
        this.fontColor = fontColor;
        this.sort = sort;
        this.contents = contents;
        this.moodBoard = moodBoard;
        moodBoard.addBoardTexts(this);
    }

}

// 고유 id / mood_board_id / x y / font_size / font_color / sort / contents