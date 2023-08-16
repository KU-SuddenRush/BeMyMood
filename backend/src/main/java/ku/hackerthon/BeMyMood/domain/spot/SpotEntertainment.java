package ku.hackerthon.BeMyMood.domain.spot;

public enum SpotEntertainment {
    DESSERT(1L, "디저트"),
    BEVERAGE(2L, "음료"),
    MUSIC(3L, "음악"),
    EXHIBITION(4L, "전시");

    private Long entertainmentId;
    private String name;

    private SpotEntertainment(Long entertainmentId, String name) {
        this.entertainmentId = entertainmentId;
        this.name = name;
    }
}
