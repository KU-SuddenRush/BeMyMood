package ku.hackerthon.BeMyMood.service.member;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
import ku.hackerthon.BeMyMood.dto.member.response.BookmarkResponseDto;
import ku.hackerthon.BeMyMood.dto.web.request.MemberInfoResponseDto;
import ku.hackerthon.BeMyMood.dto.web.request.ReviewRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.ReviewResponseDto;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface MemberService {

    Long join(MemberJoinParams params);

    Member searchByEmail(String email) throws IllegalArgumentException;

    Member searchById(Long memberId) throws IllegalArgumentException;

    MemberInfoResponseDto searchMemberInfoById(Long memberId);

    void setMemberMood(List<String> moods, Long memberId);

    List<String> getPreferredMoodNames(Long memberId);

    List<BookmarkResponseDto> getBookmarks(Long memberId);

    boolean setBookmark(Member member, Spot spot);

    boolean setMemberLocation(List<Long> locationIds, Long memberId);

    List<String> getPreferredLocationNames(Long memberId);

    void review(ReviewRequestDto requestDto, Long memberId) throws IOException;

    List<ReviewResponseDto> findAllReviewByMemberID(Long memberId);

    void setReviewImages(Long spotId, Long memberId, List<MultipartFile> files);
}
