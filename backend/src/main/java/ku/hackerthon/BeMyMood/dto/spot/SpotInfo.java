package ku.hackerthon.BeMyMood.dto.spot;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class SpotInfo {

    private Long spotId;
    private boolean bookmarked;
    private String spotName;
    private String spotThumbnailImageUrl;
    private String categoryName;
    private List<String> moodNames;
}
