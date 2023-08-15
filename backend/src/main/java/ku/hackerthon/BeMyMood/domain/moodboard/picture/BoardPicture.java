package ku.hackerthon.BeMyMood.domain.moodboard.picture;

import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import ku.hackerthon.BeMyMood.domain.spot.SpotImage;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BoardPicture {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_picture_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mood_board_id")
    private MoodBoard moodBoard;

    @OneToOne
    @JoinColumn(name = "spot_img_id")
    private SpotImage spotImage;
    // 무드보드에 등록 가능한 사진 = 스팟 시그니처

    private Double locationX;

    private Double locationY;

    private Double width;

    private Double height;

    private Double rotation;

    // Constructor
    public BoardPicture(MoodBoard moodBoard) {
        this.moodBoard = moodBoard;
        moodBoard.addBoardPictures(this);
    }

}

// 고유 id / mood_board_id / picture_id / x y / h w / rotation