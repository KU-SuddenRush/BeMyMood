package ku.hackerthon.BeMyMood.domain.member.mood;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.Mood;

import javax.persistence.CascadeType;
import javax.persistence.OneToMany;
import java.util.ArrayList;
import java.util.List;

public class MoodAccumulations {

    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL)
    private List<MoodAccumulation> moodAccumulations = new ArrayList<>();

    public int accumulate(Member member, Mood mood) {
        for (MoodAccumulation ma : moodAccumulations) {
            if (ma.isMood(mood)) { // 존재하는 MoodAccumulation이면 accumulate 증가
                ma.increase();
                return ma.getAccumulate();
            }
        }

        // 새 MoodAccumulation 추가
        MoodAccumulation moodAccumulation = new MoodAccumulation(member, mood);
        moodAccumulations.add(moodAccumulation);
        return moodAccumulation.getAccumulate();
    }
}
