package ku.hackerthon.BeMyMood.domain.review;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.spot.Spot;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Review {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_id")
    private Long id;

    @Column(name = "review_img_url")
    private String imgUrl;

    @Column(name = "review_title")
    private String title;

    @Column(name = "review_description")
    private String description;

    private LocalDate postAt;

    private Boolean opened;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne
    @JoinColumn(name = "spot_id")
    private Spot spot;

    // Constructor
    public Review(String title, String description, LocalDate postAt, Boolean opened, Member member, Spot spot) {
        this.title = title;
        this.description = description;
        this.postAt = postAt;
        this.opened = opened;
        this.member = member;
        member.addReview(this);

        this.spot = spot;
        if (opened) {
            spot.addPublicReview(this);
        }
    }

    // Method
    public void setImageUrl(String url) {
        this.imgUrl = url;
    }
}
