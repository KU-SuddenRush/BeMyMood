package ku.hackerthon.BeMyMood.domain.moodboard;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.MoodBoardPicture;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.MoodBoardPictures;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.MoodBoardSticker;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.MoodBoardStickers;
import ku.hackerthon.BeMyMood.domain.moodboard.text.MoodBoardText;
import ku.hackerthon.BeMyMood.domain.moodboard.text.MoodBoardTexts;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MoodBoard {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mood_board_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @Column(name = "mood_board_name")
    private String name;

    @Column(name = "mood_board_capture_img_url") // 무드보드 캡쳐본 url
    private String captureImgUrl;

    @Embedded
    private MoodBoardStickers stickers;

    @Embedded
    private MoodBoardPictures pictures;

    @Embedded
    private MoodBoardTexts texts;

    // Constructor
    public MoodBoard(Member member, String name, String captureImgUrl) {
        this.member = member;
        this.name = name;
        this.captureImgUrl = captureImgUrl;
        this.stickers = new MoodBoardStickers();
        this.pictures = new MoodBoardPictures();
        this.texts = new MoodBoardTexts();
        member.addMoodBoard(this);
    }

    // Method
    public void addBoardStickers(MoodBoardSticker boardSticker) { this.stickers.add(boardSticker); }

    public void addBoardPictures(MoodBoardPicture boardPicture) { this.pictures.add(boardPicture); }

    public void addBoardTexts(MoodBoardText boardText) { this.texts.add(boardText); }
}