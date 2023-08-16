package ku.hackerthon.BeMyMood.dto.moodboard.store;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoardTextParams {
    private Double locationX;
    private Double locationY;
    private Long fontSize;
    private int fontColor;
    private int sort;
    private String contents;
}

// x y / font -> size, color / sort / contents