package ku.hackerthon.BeMyMood.service.moodboard;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import org.springframework.web.multipart.MultipartFile;

public interface MoodBoardService {

    void moodBoard(Member member, MultipartFile file, MoodBoardRequestDto requestDto);
}
