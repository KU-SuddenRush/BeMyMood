package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.web.response.RecommendedSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.SpotDetailsResponseDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    /**
     * <b>스팟 상세 리스트 조회</b>
     * @param spotId 스팟에 할당된 식별자
     * @return {@link SpotDetailsResponseDto}
     */
    @GetMapping("/{spotId}/details")
    public ResponseEntity<SpotDetailsResponseDto> getSpotDetails(
            @PathVariable Long spotId,
            @State Long memberId
    ) {
        Spot spot = spotService.searchById(spotId);
        Member member = memberService.searchById(memberId);
        SpotDetailsResponseDto responseDto = spotService.getSpotDetails(spot, member);
        return ResponseEntity.ok(responseDto);
    }
}
