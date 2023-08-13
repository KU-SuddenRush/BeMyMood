package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.spot.RecommendedSpotInfo;
import ku.hackerthon.BeMyMood.dto.spot.SpotFilterParams;
import ku.hackerthon.BeMyMood.dto.web.response.FilteredSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.RecommendedSpotsResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.SpotDetailsResponseDto;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/spot")
@RestController
public class SpotController {

    private final SpotService spotService;
    private final MemberService memberService;

    /**
     * <b>추천 스팟 리스트 조회</b>
     * @param memberId statemanager에 저장된 memberId
     * @return List 형식의 {@link RecommendedSpotInfo}
     */
    @GetMapping("/recommend")
    public ResponseEntity<RecommendedSpotsResponseDto> getRecommendedSpots(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        RecommendedSpotsResponseDto responseDto = spotService.recommend(member.getPreferredLocations(), member.getPreferredMoods());
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>스팟 상세 정보 조회</b>
     * @param spotId 스팟에 할당된 식별자
     * @param memberId 멤버 식별자, bookmark된 스팟인지 확인하기 위함.
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

    @GetMapping("/filter")
    public ResponseEntity<FilteredSpotsResponseDto> getFilteredSpots(
            @RequestParam(name = "category_id", required = false) Long categoryId,
            @RequestParam(name = "location_id", required = false) Long locationId,
            @RequestParam(name = "mood_id", required = false) Long moodId
    ) {
        SpotFilterParams params = new SpotFilterParams(categoryId, locationId, moodId);
        FilteredSpotsResponseDto responseDto = spotService.filter(params);
        return ResponseEntity.ok(responseDto);
    }

}
