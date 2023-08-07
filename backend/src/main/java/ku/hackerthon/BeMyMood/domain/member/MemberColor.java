package ku.hackerthon.BeMyMood.domain.member;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MemberColor {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_color_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "color_id")
    private Color color;
}