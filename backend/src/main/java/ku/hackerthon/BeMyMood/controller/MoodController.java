package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.service.mood.MoodService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/mood")
public class MoodController {
    private final MoodService moodService;

    /**
     * <b>색상 리스트 반환</b>
     * @return List<Long> id 리스트</String>
     */
    @GetMapping("/color")
    public ResponseEntity<List<Long>> getAllColors() {
        List<Long> response = moodService.getAllColors();
        return ResponseEntity.ok(response);
    }

    /**
     * <b>분위기 리스트 반환</b>
     * @return List<Long> id 리스트</String>
     */
    @GetMapping("/vibe")
    public ResponseEntity<List<Long>> getAllVibes() {
        List<Long> response = moodService.getAllVibes();
        return ResponseEntity.ok(response);
    }
}