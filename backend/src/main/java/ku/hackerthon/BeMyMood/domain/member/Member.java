package ku.hackerthon.BeMyMood.domain.member;

import ku.hackerthon.BeMyMood.domain.member.tag.MemberColor;
import ku.hackerthon.BeMyMood.domain.member.tag.MemberLocation;
import ku.hackerthon.BeMyMood.domain.member.tag.MemberMood;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
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

    @OneToMany(mappedBy = "member")
    private List<MemberColor> memberColors = new ArrayList<>();

    @OneToMany(mappedBy = "member")
    private List<MemberMood> memberMoods = new ArrayList<>();

    @OneToMany(mappedBy = "member")
    private List<MemberLocation> memberLocations = new ArrayList<>();
}