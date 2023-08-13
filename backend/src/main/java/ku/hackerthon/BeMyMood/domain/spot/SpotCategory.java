package ku.hackerthon.BeMyMood.domain.spot;

import java.util.Arrays;

public enum SpotCategory {
    CAFE("카페"),
    THEME_CAFE("테마카페"),
    RESTAURANT("음식점"),
    NONE("기타");

    private String name;

    private SpotCategory(String name) {
        this.name = name;
    }

    public static SpotCategory ofName(String name) {
        return Arrays.stream(SpotCategory.values())
                .filter(spotCategory -> spotCategory.name.equals(name))
                .findAny()
                .orElse(NONE);
    }

    public String getName() {
        return this.name;
    }
}
