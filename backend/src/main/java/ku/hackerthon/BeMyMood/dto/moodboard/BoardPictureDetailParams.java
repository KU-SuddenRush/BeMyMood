package ku.hackerthon.BeMyMood.dto.moodboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoardPictureDetailParams {
    //private Long spotImgId;
    //private String spotImgUrl;
    private String imgItemUrl;
    private Double locationX;
    private Double locationY;
    private Double width;
    private Double height;
    private Double rotation;
}

// id / x y / h w / rotation