package ku.hackerthon.BeMyMood.dto.web.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class SpotDetailsResponseDto {

    private Long spotId;
    private boolean bookmarked;
    private String categoryName;
    private String spotName;
    private List<String> moodNames;
    private List<String> spotImageUrls;
    private String address;
    private String contact;
    private String operationInfo;
    private String introduce;
//    private List<String> entertainmentNames;
//    private List<String> menuImageUrls;
}
