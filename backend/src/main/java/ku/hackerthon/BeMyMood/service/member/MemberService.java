package ku.hackerthon.BeMyMood.service.member;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;

public interface MemberService {

    Long join(MemberJoinParams params);

    Member searchByEmail(String email) throws IllegalArgumentException;
}
