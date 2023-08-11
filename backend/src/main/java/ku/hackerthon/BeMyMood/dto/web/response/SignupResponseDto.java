package ku.hackerthon.BeMyMood.dto.web.response;

import lombok.Getter;

@Getter
public class SignupResponseDto {

    private Long memberId;

    public SignupResponseDto(Long joinMemberId) {
        this.memberId = joinMemberId;
    }
}
