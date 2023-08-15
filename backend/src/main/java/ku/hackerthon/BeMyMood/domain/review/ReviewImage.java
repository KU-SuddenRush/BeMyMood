package ku.hackerthon.BeMyMood.domain.review;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ReviewImage {
    @Id  @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "review_img_id")
    private Long id;

    @Column(name = "review_img_url")
    private String imgUrl;

    @ManyToOne
    @JoinColumn(name = "review_id")
    private Review review;

    public ReviewImage(String imgUrl, Review review) {
        this.imgUrl = imgUrl;
        this.review = review;
    }
}
