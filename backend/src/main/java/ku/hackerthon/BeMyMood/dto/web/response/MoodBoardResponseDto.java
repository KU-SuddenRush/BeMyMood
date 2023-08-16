package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.moodboard.MoodBoardParams;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class MoodBoardResponseDto {
    private List<MoodBoardParams> moodBoards;
}