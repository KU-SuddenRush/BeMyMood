package ku.hackerthon.BeMyMood.service.member;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMood;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.dto.web.request.MemberInfoResponseDto;
import ku.hackerthon.BeMyMood.respository.MemberRepository;
import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
import ku.hackerthon.BeMyMood.service.mood.MoodService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Transactional
@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

    private final MemberRepository memberRepository;
    private final MoodService moodService;

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

    @Override
    public Member searchById(Long memberId) throws IllegalArgumentException {
        return memberRepository.findById(memberId)
                .orElseThrow(() -> new IllegalArgumentException("wrong id"));
    }

    @Override
    public MemberInfoResponseDto searchMemberInfoById(Long memberId) {
        Member member = searchById(memberId);
        return new MemberInfoResponseDto(
                member.getId(),
                member.getName(),
                member.getEmail()
        );
    }

    @Override
    public void setMemberMood(List<String> moods, Long memberId) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() -> new IllegalArgumentException("wrong id"));

        for (String mood : moods) {
            Mood selectedMood = moodService.getByName(mood);

            // 이미 선택한 무드 -> 생략
            if (member.getPreferredMoods().hasMood(selectedMood)) continue;

            member.addMood(new PreferredMood(member, selectedMood));
        }
    }
}
