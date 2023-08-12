package ku.hackerthon.BeMyMood.service.mood;

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

        // when
        List<String> findColors = moodService.getAllColors();

        // then
        assertThat(findColors).containsAll(colors);

    }

}