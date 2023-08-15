package ku.hackerthon.BeMyMood.dto.moodboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoardPictureParams {
    private Long spotImgId;
    private Double locationX;
    private Double locationY;
    private Double width;
    private Double height;
    private Double rotation;
}

// id / x y / h w / rotation