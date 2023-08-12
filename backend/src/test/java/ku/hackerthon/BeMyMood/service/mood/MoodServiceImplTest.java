package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.mood.MoodType;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.*;

@Transactional
@SpringBootTest
class MoodServiceImplTest {
    @Autowired
    private MoodService moodService;

    @Test
    @DisplayName("DB에서 색상 리스트 조회 후 동등성 테스트")
    void getAllColors() throws Exception {
        // given
        List<String> colors = List.of("#뮤트한", "#비비드한", "#차분한", "#빛바랜", "#무채색의", "#파스텔의", "#블랙앤화이트",
                "#자연적인", "#투명한", "#매트한", "#형광의", "#쿨한", "#웜한");
        for (String color : colors) {
            Mood tempMood = new Mood(color, MoodType.COLOR);
            moodService.register(tempMood);
        }

        // when
        List<String> findColors = moodService.getAllColors();

        // then
        assertThat(findColors).containsAll(colors);

    }

    @Test
    @DisplayName("DB에서 분위기 리스트 조회 후 동등성 테스트")
    void getAllVibes() throws Exception {
        // given
        List<String> vibes = List.of("#엔틱", "#빈티지", "#키치한", "#Y2K", "#힙한", "#우디", "#어두운", "#아기자기한", "#모노톤의", "#미니멀한",
                "#인더스트리얼", "#식물이많은", "#반려동물과함께", "#특이한소재의", "#풍경위주의", "#여유로운", "#연인과함께", "#친구와함께", "#컬러풀한",
                "#포인트컬러", "#미래지향적인", "#영화컨셉의", "#소품이많은", "#고풍스러운", "#한국적인", "#밤과어울리는", "#야경이예쁜", "#고즈넉한",
                "#별이보이는", "#화려한조명", "#한적한", "#볼거리가많은", "#로컬의", "#이국적인", "#은은한조명의", "#LP가흐르는", "#루프탑", "#복고풍의");
        for (String vibe : vibes) {
            Mood tempMood = new Mood(vibe, MoodType.VIBE);
            moodService.register(tempMood);
        }

        // when
        List<String> findVibes = moodService.getAllVibes();

        // then
        assertThat(findVibes).containsAll(vibes);

    }

}