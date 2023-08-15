package ku.hackerthon.BeMyMood.domain.moodboard;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.BoardPicture;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.BoardPictures;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.BoardSticker;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.BoardStickers;
import ku.hackerthon.BeMyMood.domain.moodboard.text.BoardText;
import ku.hackerthon.BeMyMood.domain.moodboard.text.BoardTexts;
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

    @Column(name = "mood_board_img_url") // 무드보드 캡쳐본 url
    private String imgUrl;

    @Embedded
    private BoardStickers stickers;

    @Embedded
    private BoardPictures pictures;

    @Embedded
    private BoardTexts texts;

    // Constructor
    public MoodBoard(Member member) {
        this.member = member;
        this.stickers = new BoardStickers();
        this.pictures = new BoardPictures();
        this.texts = new BoardTexts();
        member.addMoodBoard(this);
    }

    // Method
    public void addBoardStickers(BoardSticker boardSticker) { this.stickers.add(boardSticker); }

    public void addBoardPictures(BoardPicture boardPicture) { this.pictures.add(boardPicture); }

    public void addBoardTexts(BoardText boardText) { this.texts.add(boardText); }
}