package ku.hackerthon.BeMyMood.respository;

import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.Optional;

@Repository
@RequiredArgsConstructor
public class MoodBoardRepository {
    private final EntityManager em;

    public Optional<MoodBoard> findById(Long moodBoardId) {
        return Optional.ofNullable(em.find(MoodBoard.class, moodBoardId));
    }
}
