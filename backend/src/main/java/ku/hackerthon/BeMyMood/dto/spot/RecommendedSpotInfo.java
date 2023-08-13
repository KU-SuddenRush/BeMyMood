package ku.hackerthon.BeMyMood.dto.spot;

import lombok.Getter;

import java.util.List;

@Getter
public class RecommendedSpotInfo extends SpotInfo {

    public RecommendedSpotInfo(Long id, String name, String imgUrl, String categoryName, List<String> moodNames) {
        super(id, false, name, imgUrl, categoryName, moodNames);
    }
}
