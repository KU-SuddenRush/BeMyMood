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

    public void addMood(Member member, Mood mood) {
        for (MoodAccumulation ma : moodAccumulations) {
            if (ma.isMood(mood)) {
                ma.increase();
                return;
            }
        }
        moodAccumulations.add(new MoodAccumulation(member, mood));
    }
}
