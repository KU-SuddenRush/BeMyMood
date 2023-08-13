package ku.hackerthon.BeMyMood.domain.spot;

import java.util.Arrays;

public enum SpotCategory {
    CAFE(1L, "카페"),
    THEME_CAFE(2L, "테마카페"),
    RESTAURANT(3L, "음식점"),
    NONE(0L, "기타");

    private Long id;
    private String name;

    private SpotCategory(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public static SpotCategory ofName(String name) {
        return Arrays.stream(SpotCategory.values())
                .filter(spotCategory -> spotCategory.name.equals(name))
                .findAny()
                .orElse(NONE);
    }

    public static SpotCategory ofId(Long categoryId) {
        return Arrays.stream(SpotCategory.values())
                .filter(spotCategory -> spotCategory.id.equals(categoryId))
                .findAny()
                .orElse(NONE);
    }
}
