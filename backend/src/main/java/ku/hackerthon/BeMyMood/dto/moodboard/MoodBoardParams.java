package ku.hackerthon.BeMyMood.dto.moodboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MoodBoardParams {
    private Long moodBoardId;
    private String moodBoardName;
    private String moodBoardCaptureUrl;
}
