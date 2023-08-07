package ku.hackerthon.BeMyMood.domain.member;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Member {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    @Column(name = "member_name")
    private String name;

    private String email;

    private String password;

    @OneToMany(mappedBy = "color")
    private List<MemberColor> memberColors;

    @OneToMany(mappedBy = "mood")
    private List<MemberMood> memberMoods;

    @OneToMany(mappedBy = "location")
    private List<MemberLocation> memberLocations;
}