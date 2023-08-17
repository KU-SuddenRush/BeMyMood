package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.moodboard.BoardPictureDetailParams;
import ku.hackerthon.BeMyMood.dto.moodboard.BoardStickerParams;
import ku.hackerthon.BeMyMood.dto.moodboard.BoardTextParams;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

@Getter
@AllArgsConstructor
public class MoodBoardDetailResponseDto {
    private Long moodBoardId;
    private String moodBoardName;
    private List<BoardPictureDetailParams> pictures;
    private List<BoardStickerParams> stickers;
    private List<BoardTextParams> texts;

    public MoodBoardDetailResponseDto(Long id, String name) {
        this.moodBoardId = id;
        this.moodBoardName = name;
        pictures = new ArrayList<>();
        stickers = new ArrayList<>();
        texts = new ArrayList<>();
    }
}
