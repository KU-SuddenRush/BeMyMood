package ku.hackerthon.BeMyMood.service.auth.state;

public interface StateManager<K, V> {

    /**
     * (key, value) 형식으로 state 정보를 저장
     * @param key  key
     * @param value  value
     */
    void store(K key, V value);

    V get(K key);
}
