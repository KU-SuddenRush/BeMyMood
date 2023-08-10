package ku.hackerthon.BeMyMood.service.storage;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import static org.assertj.core.api.Assertions.*;

@Slf4j
@SpringBootTest
class StorageServiceTest {
    @Autowired
    private StorageService storageService;

    @Test
    @DisplayName("S3 이미지 업로드 테스트")
    public void imageUpload() throws Exception {
        // given
        String fileName = "git.jpeg";
        String contentType = "jpeg";
        String filePath = "./src/test/resources/image/git.jpeg";
        MockMultipartFile mockMultipartFile = getMockMultipartFile(fileName, contentType, filePath);

        // when
        String imgUrl = storageService.uploadToS3(mockMultipartFile, fileName);
        String storageImgName = storageService.getFileNameFromUrl(imgUrl);

        // then
        assertThat(fileName).isEqualTo(storageImgName);
    }

    private MockMultipartFile getMockMultipartFile(String fileName, String contentType, String path) throws IOException {
        FileInputStream fileInputStream = new FileInputStream(new File(path));
        return new MockMultipartFile(fileName, fileName + "." + contentType, contentType, fileInputStream);
    }
}