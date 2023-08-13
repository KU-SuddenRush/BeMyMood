package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.dto.web.response.RecommendedSpotsResponseDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/spot")
@RestController
public class SpotController {

    private final SpotService spotService;
    private final MemberService memberService;

    /**
     * <b>추천 스팟 리스트 조회</b>
     * @param memberId statemanager에 저장된 memberId
     * @return List 형식의 {@link ku.hackerthon.BeMyMood.dto.spot.RecommendedSpot}
     */
    @GetMapping("/recommend")
    public ResponseEntity<RecommendedSpotsResponseDto> getRecommendedSpots(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        RecommendedSpotsResponseDto responseDto = spotService.recommend(member.getPreferredLocations(), member.getPreferredMoods());
        return ResponseEntity.ok(responseDto);
    }
}
