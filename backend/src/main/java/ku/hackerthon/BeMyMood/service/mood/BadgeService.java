package ku.hackerthon.BeMyMood.service.mood;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.mood.Mood;
import ku.hackerthon.BeMyMood.domain.mood.badge.Badge;
import ku.hackerthon.BeMyMood.dto.web.response.BadgeResponseDto;
import ku.hackerthon.BeMyMood.respository.BadgeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Transactional
@RequiredArgsConstructor
@Service
public class BadgeService {

    private final BadgeRepository badgeRepository;

    public Badge findByMood(Mood mood) {
        return badgeRepository.findByMoodId(mood.getId());
    }

    public List<BadgeResponseDto> getBadgesByMemberId(Long memberId) {
        List<Badge> badges = badgeRepository.findAllByMemberId(memberId);

        return badges.stream()
                .map(badge -> new BadgeResponseDto(
                            badge.getImageUrl(),
                            badge.getName(),
                            badge.getMood().getName(),
                            badge.getDescription()
                    )
                ).collect(Collectors.toList());
    }

    public void issueMemberBadge(Member member, Mood mood) {
        Badge badge = findByMood(mood);
        member.addBadge(badge);
    }

    public List<BadgeResponseDto> getAllBadges(Member member) {
        List<Badge> badges = member.getMemberBadges()
                                   .getBadges();

        badges.addAll(badgeRepository.findAllLockedBy(member));

        return badges.stream()
                .map(badge -> new BadgeResponseDto(
                                badge.getImageUrl(),
                                badge.getName(),
                                badge.getMood().getName(),
                                badge.getDescription()
                        )
                ).collect(Collectors.toList());
    }
}
