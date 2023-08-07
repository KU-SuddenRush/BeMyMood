package ku.hackerthon.BeMyMood.domain.tag;

import javax.persistence.*;

@Entity
public class Mood {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mood_id")
    private Long id;

    @Column(name = "mood_name")
    private String name;
}
