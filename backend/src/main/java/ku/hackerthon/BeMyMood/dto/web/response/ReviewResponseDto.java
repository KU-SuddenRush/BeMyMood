package ku.hackerthon.BeMyMood.dto.web.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import java.time.LocalDate;

@Getter
@AllArgsConstructor
public class ReviewResponseDto {

    private String memberName;
    private String reviewImageUrl;
    private String description;
    private LocalDate postAd;
    private Boolean opened;
}
