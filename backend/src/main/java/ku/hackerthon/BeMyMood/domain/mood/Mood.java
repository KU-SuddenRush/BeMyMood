package ku.hackerthon.BeMyMood.domain.mood;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@Entity
public class Mood {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "mood_id")
    private Long id;

    @Column(name = "mood_name")
    private String name;

    @Enumerated(EnumType.STRING)
    private MoodType type;

    // Constructor
    public Mood(String name, MoodType type) {
        this.name = name;
        this.type = type;
    }

    // Method
    @Override
    public boolean equals(Object obj) {
        Mood another = (Mood) obj;
        return this.name.equals(another.getName());
    }
}
