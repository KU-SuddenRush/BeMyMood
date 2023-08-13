package ku.hackerthon.BeMyMood.dto.spot;

import lombok.Getter;

import java.util.List;

@Getter
public class FilteredSpotInfo extends SpotInfo {

    public FilteredSpotInfo(Long id, String name, String imgUrl, String categoryName, List<String> moodNames) {
        super();
    }
}
