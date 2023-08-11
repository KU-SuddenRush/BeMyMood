package ku.hackerthon.BeMyMood.testnote.code;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.*;

public class InitialTest {

    @Test
    void initial_test() {
        int a = 1;

        assertThat(a).isEqualTo(1);
    }

    @Test
    void sum_test() {
        int a = 1;
        int b = 1;

        assertThat(a + b).isEqualTo(2);
    }
}
