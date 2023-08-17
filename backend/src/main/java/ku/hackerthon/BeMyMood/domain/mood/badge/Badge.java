package ku.hackerthon.BeMyMood.domain.mood.badge;

import ku.hackerthon.BeMyMood.domain.mood.Mood;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Badge {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "badge_id")
    private Long id;

    @Column(name = "badge_name")
    private String name;

    @OneToOne
    @JoinColumn(name = "mood_id")
    private Mood mood;

    @Column(name = "badge_image_url")
    private String imageUrl;

    @Column(name = "locked_badge_image_url")
    private String lockedImageUrl;

    private String description;

    // Method
    @Override
    public boolean equals(Object obj) {
        Badge another = (Badge) obj;
        return this.mood.equals(another.getMood());
    }
}
