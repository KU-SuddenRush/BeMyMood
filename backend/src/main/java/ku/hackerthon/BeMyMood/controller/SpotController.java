package ku.hackerthon.BeMyMood.controller;

import ku.hackerthon.BeMyMood.aop.annotation.State;
import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import ku.hackerthon.BeMyMood.dto.spot.RecommendedSpotInfo;
import ku.hackerthon.BeMyMood.dto.spot.SpotFilterParams;
import ku.hackerthon.BeMyMood.dto.web.request.SpotCreateRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.*;
import ku.hackerthon.BeMyMood.service.member.MemberService;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/spot")
@RestController
public class SpotController {

    private final SpotService spotService;
    private final MemberService memberService;

    /**
     * 새로운 스팟 등록
     */
    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Long> create(
            @RequestPart("data") SpotCreateRequestDto requestDto,
            @RequestPart("files") List<MultipartFile> files
    ) {
        Long spotId = spotService.register(requestDto);
        spotService.registerImages(spotId, files);
        return ResponseEntity.ok(spotId);
    }
    /**
     * 전체 스팟 조회
     */
    @GetMapping("/info/all")
    public ResponseEntity<AllSpotInfoResponseDto> getAllSpotInfos() {
        AllSpotInfoResponseDto responseDto = spotService.getAllInfo();
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>추천 스팟 리스트 조회</b>
     *
     * @param memberId statemanager에 저장된 memberId
     * @return List 형식의 {@link RecommendedSpotInfo}
     */
    @GetMapping("/info/recommend")
    public ResponseEntity<RecommendedSpotsResponseDto> getRecommendedSpots(@State Long memberId) {
        Member member = memberService.searchById(memberId);
        RecommendedSpotsResponseDto responseDto = spotService.recommend(member.getPreferredLocations(), member.getPreferredMoods());
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>스팟 상세 정보 조회</b>
     *
     * @param spotId   스팟에 할당된 식별자
     * @param memberId 멤버 식별자, bookmark된 스팟인지 확인하기 위함.
     * @return {@link SpotDetailsResponseDto}
     */
    @GetMapping("/{spotId}/detail")
    public ResponseEntity<SpotDetailsResponseDto> getSpotDetails(
            @PathVariable Long spotId,
            @State Long memberId
    ) {
        Spot spot = spotService.searchById(spotId);
        Member member = memberService.searchById(memberId);
        SpotDetailsResponseDto responseDto = spotService.getSpotDetails(spot, member);
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>무드별 - 스팟 필터링 조회</b>
     *
     * @return
     */
    @GetMapping("/info/filter")
    public ResponseEntity<FilteredSpotsResponseDto> getFilteredSpots(
            @RequestParam(name = "category_id", required = false) Long categoryId,
            @RequestParam(name = "location_id", required = false) Long locationId,
            @RequestParam(name = "mood_id", required = false) Long moodId
    ) {
        SpotFilterParams params = new SpotFilterParams(categoryId, locationId, moodId);
        FilteredSpotsResponseDto responseDto = spotService.filter(params);
        return ResponseEntity.ok(responseDto);
    }

    /**
     * <b>스팟 리뷰(공개 설정된 기록) 조회</b>
     *
     * @param spotId   스팟에 할당된 식별자
     * @return {@link SpotDetailsResponseDto}
     */
    @GetMapping("/{spotId}/review")
    public ResponseEntity<SpotPublicReviewsResponseDto> getSpotReviews(@PathVariable Long spotId) {
        Spot spot = spotService.searchById(spotId);
        SpotPublicReviewsResponseDto responseDto = spotService.getSpotReviews(spot);
        return ResponseEntity.ok(responseDto);
    }
}
