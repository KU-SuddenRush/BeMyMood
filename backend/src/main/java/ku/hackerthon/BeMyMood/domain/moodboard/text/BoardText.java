package ku.hackerthon.BeMyMood.domain.moodboard.text;

import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BoardText {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_text_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mood_board_id")
    private MoodBoard moodBoard;

    private Double locationX;

    private Double locationY;

    private Long fontSize;

    private String fontColor;

    private String sort;

    private String contents;

    // Constructor
    public BoardText(MoodBoard moodBoard) {
        this.moodBoard = moodBoard;
        moodBoard.addBoardTexts(this);
    }

}

// 고유 id / mood_board_id / x y / font_size / font_color / sort / contents