package ku.hackerthon.BeMyMood.domain.tag;

import javax.persistence.*;

@Entity
public class Color {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "color_id")
    private Long id;

    @Column(name = "color_name")
    private String name;
}
