package ku.hackerthon.BeMyMood.dto.moodboard;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class LastMoodBoardResponseDto {
    private boolean isExist;
    private MoodBoardInfo moodBoardInfo;
}
