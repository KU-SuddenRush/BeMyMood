package ku.hackerthon.BeMyMood.dto.web.response;

import ku.hackerthon.BeMyMood.dto.moodboard.SpotSignatureImageParams;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class SpotSignatureImagesResponseDto {
    private List<SpotSignatureImageParams> spotSignatureImageParams;
}
