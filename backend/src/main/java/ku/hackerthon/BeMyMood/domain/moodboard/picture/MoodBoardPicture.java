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
public class MoodBoardPicture {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_picture_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "mood_board_id")
    private MoodBoard moodBoard;

    private String imgItemUrl;

    private Double locationX;

    private Double locationY;

    private Double width;

    private Double height;

    private Double rotation;

    // Constructor
    public MoodBoardPicture(MoodBoard moodBoard, String imgItemUrl, Double locationX, Double locationY, Double width, Double height, Double rotation) {
        this.imgItemUrl = imgItemUrl;
        this.locationX = locationX;
        this.locationY = locationY;
        this.width = width;
        this.height = height;
        this.rotation = rotation;
        this.moodBoard = moodBoard;
        moodBoard.addBoardPictures(this);
    }

}

// 고유 id / mood_board_id / picture_id / x y / h w / rotation