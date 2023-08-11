package ku.hackerthon.BeMyMood.service.member;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.respository.MemberRepository;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

    private final MemberRepository memberRepository;

    @Override
    public Long join(MemberJoinParams params) {
        Member member = Member.builder()
                .name(params.getName())
                .email(params.getEmail())
                .password(params.getPassword())
                .build();

        return memberRepository.save(member);
    }

    @Override
    public Member searchByEmail(String email) throws IllegalArgumentException {
        return memberRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("wrong email"));
    }
}
