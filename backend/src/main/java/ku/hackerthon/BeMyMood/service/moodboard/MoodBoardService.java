package ku.hackerthon.BeMyMood.service.moodboard;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.dto.moodboard.MoodBoardInfo;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import ku.hackerthon.BeMyMood.dto.web.request.SpotSignatureImagesResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.MoodBoardResponseDto;
import org.springframework.web.multipart.MultipartFile;

public interface MoodBoardService {

    void moodBoard(Member member, MultipartFile file, MoodBoardRequestDto requestDto);

    MoodBoardResponseDto getAllMoodBoards(Member member);

    MoodBoardInfo getLastEditedMoodBoard(Member member);

    SpotSignatureImagesResponseDto getSpotSignatureImages(Member member);
}
