package ku.hackerthon.BeMyMood.dto.spot;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;

@Getter
@AllArgsConstructor
public class SpotPublicReviewsInfo {
    private Long reviewId;
    private Long spotId;
    private List<String> reviewImages;
    private String description;
    private LocalDate postAt;
//    private Long memberId;
//    private String name;
}
