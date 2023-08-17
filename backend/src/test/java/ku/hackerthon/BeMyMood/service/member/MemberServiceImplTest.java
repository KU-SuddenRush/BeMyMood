//package ku.hackerthon.BeMyMood.service.member;
//
//import ku.hackerthon.BeMyMood.domain.member.Member;
//import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
//import ku.hackerthon.BeMyMood.domain.mood.Mood;
//import ku.hackerthon.BeMyMood.domain.mood.MoodType;
//import ku.hackerthon.BeMyMood.dto.member.MemberJoinParams;
//import ku.hackerthon.BeMyMood.service.mood.MoodService;
//import org.junit.jupiter.api.DisplayName;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import static org.assertj.core.api.Assertions.*;
//
//@Transactional
//@SpringBootTest
//class MemberServiceImplTest {
//    @Autowired
//    MemberService memberService;
//    @Autowired
//    MoodService moodService;
//
//    @Test
//    @DisplayName("좋아하는 무드 입력 테스트")
//    void setMemberService() throws Exception {
//        // given
//        List<String> colors = List.of("#뮤트한", "#비비드한", "#차분한", "#빛바랜", "#무채색의", "#파스텔의", "#블랙앤화이트",
//                "#자연적인", "#투명한", "#매트한", "#형광의", "#쿨한", "#웜한");
//        for (String color : colors) {
//            Mood tempMood = new Mood(color, MoodType.COLOR);
//            moodService.register(tempMood);
//        }
//
//        // when
//        List<String> selectMoods = List.of("#무채색의", "#파스텔의", "#블랙앤화이트");
//        List<Mood> moods = new ArrayList<>();
//        for (String selectMood : selectMoods) {
//            moods.add(moodService.getByName(selectMood));
//        }
//
//        MemberJoinParams newMember = new MemberJoinParams("testUser", "test@gmail.com", "12345");
//        memberService.join(newMember);
//        Long memberId = 1L;
//        Member member = memberService.searchById(memberId);
//
//        memberService.setMemberMood(selectMoods, memberId);
//        PreferredMoods preferredMoods = member.getPreferredMoods();
//
//        // then
//        for (Mood mood : moods) {
//            assertThat(preferredMoods.hasMood(mood)).isTrue();
//            System.out.println("mood.getName() = " + mood.getName());
//            System.out.println("mood.getType() = " + mood.getType());
//            System.out.println();
//        }
//
//    }
//}