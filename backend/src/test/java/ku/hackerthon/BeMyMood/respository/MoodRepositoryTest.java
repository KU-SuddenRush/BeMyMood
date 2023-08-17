package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.mood.MoodType;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;

@Transactional
@SpringBootTest
class MoodRepositoryTest {

    @Autowired
    EntityManager entityManager;
    @Autowired
    MoodRepository repository;

    @Test
    void 이름_전문으로_mood검색() {
        // given
        String moodName = "#힙한";
        entityManager.persist(new Mood(moodName, MoodType.VIBE));

        // when
        Mood mood = repository.findByName(moodName);

        // then
        assertThat(mood.getName()).isEqualTo(moodName);
    }

}