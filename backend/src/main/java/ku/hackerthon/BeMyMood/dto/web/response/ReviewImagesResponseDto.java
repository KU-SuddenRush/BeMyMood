package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.moodboard.ReviewImageParams;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class ReviewImagesResponseDto {
    private int count;
    private List<ReviewImageParams> reviewImageParams;
}
