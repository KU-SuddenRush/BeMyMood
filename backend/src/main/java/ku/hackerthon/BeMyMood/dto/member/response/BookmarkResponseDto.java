package ku.hackerthon.BeMyMood.dto.member.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class BookmarkResponseDto {
    private String mainImgUrl;
    private Long spotId;
    private String spotName;
    private List<String> moodNames;
    private String address;
    private String categoryName;
}
