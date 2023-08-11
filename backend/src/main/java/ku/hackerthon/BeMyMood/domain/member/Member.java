package ku.hackerthon.BeMyMood.domain.member;

import ku.hackerthon.BeMyMood.domain.member.location.PreferredLocations;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMood;
import ku.hackerthon.BeMyMood.domain.member.mood.PreferredMoods;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
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

    @Embedded
    private PreferredMoods preferredMoods;

    @Embedded
    private PreferredLocations preferredLocations;

    // Constructor
    @Builder
    public Member(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.preferredMoods = new PreferredMoods();
        this.preferredLocations = new PreferredLocations();
    }

    // Method
    public void addMood(PreferredMood preferredMood) {
        this.preferredMoods.add(preferredMood);
    }

    public boolean matchPassword(String password) {
        return this.password.equals(password);
    }
}