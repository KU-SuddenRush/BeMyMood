package ku.hackerthon.BeMyMood.dto.web.request;

import ku.hackerthon.BeMyMood.dto.moodboard.store.BoardPictureParams;
import ku.hackerthon.BeMyMood.dto.moodboard.store.BoardStickerParams;
import ku.hackerthon.BeMyMood.dto.moodboard.store.BoardTextParams;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class MoodBoardRequestDto {
    private String moodBoardName;
    private List<BoardStickerParams> stickers;
    private List<BoardPictureParams> pictures;
    private List<BoardTextParams> texts;

    // 스티커 / 사진 / 텍스트
}
