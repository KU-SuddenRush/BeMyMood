package ku.hackerthon.BeMyMood.dto.web.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ReviewRequestDto {

    private String description;
    private Boolean opened;
}
