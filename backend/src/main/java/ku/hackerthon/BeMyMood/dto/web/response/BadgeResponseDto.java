package ku.hackerthon.BeMyMood.dto.web.response;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class BadgeResponseDto {

    private String badgeImageUrl;
    private String badgeName;
    private String moodName;
    private String description;
    private Boolean gained;
}
