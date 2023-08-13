package ku.hackerthon.BeMyMood.dto.storage;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
@AllArgsConstructor
public enum StorageDomain {
    MEMBER("member"), SPOT("spot"), REVIEW("review"), STICKER("sticker"), BADGE("badge");

    private String domain;
}
