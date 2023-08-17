package ku.hackerthon.BeMyMood.service.auth.state;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
public class InMemorySessionStateManager implements StateManager<String, Long> {

    private final Map<String, Long> sessionStore = new HashMap<>();

    @Override
    public void store(String key, Long value) {
        sessionStore.put(key, value);
        log.info("state [{} : {}] stored", key, value);
        log.info("[store size : {} / store infos : {}]", sessionStore.size(), sessionStore);
    }

    @Override
    public Long get(String key) {
        return sessionStore.get(key);
    }
}
