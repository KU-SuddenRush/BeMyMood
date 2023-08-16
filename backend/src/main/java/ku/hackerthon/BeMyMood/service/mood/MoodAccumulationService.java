package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.member.mood.MoodAccumulations;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class MoodAccumulationService {

    private final BadgeService badgeService;

    public void accumulate(Member member, Mood mood) {
        MoodAccumulations moodAccumulations = member.getMoodAccumulations();

        int accumulated = moodAccumulations.accumulate(member, mood);
        if (accumulated >= 3) {
            badgeService.issueMemberBadge(member, mood);
        }
    }
}
