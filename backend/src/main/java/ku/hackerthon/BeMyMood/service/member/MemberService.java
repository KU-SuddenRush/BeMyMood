package ku.hackerthon.BeMyMood.service.member;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
import ku.hackerthon.BeMyMood.dto.web.request.MemberInfoResponseDto;

import java.util.List;

public interface MemberService {

    Long join(MemberJoinParams params);

    Member searchByEmail(String email) throws IllegalArgumentException;

    Member searchById(Long memberId) throws IllegalArgumentException;

    MemberInfoResponseDto searchMemberInfoById(Long memberId);

    void setMemberMood(List<String> moods, Long memberId);

    List<String> getPreferredMoodNames(Long memberId);
}
