package ku.hackerthon.BeMyMood.dto.moodboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoardStickerParams {
    private Long stickerId;
    private Double locationX;
    private Double locationY;
    private Double width;
    private Double height;
    private Double rotation;
}

// 스티커 - id / x y / h w / rotation
