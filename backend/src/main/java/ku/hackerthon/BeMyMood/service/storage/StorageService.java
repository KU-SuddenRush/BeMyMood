package ku.hackerthon.BeMyMood.service.storage;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import ku.hackerthon.BeMyMood.dto.storage.StorageDomain;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InvalidObjectException;
import java.time.LocalDateTime;

@Slf4j
@RequiredArgsConstructor
@Service
public class StorageService {

    @Value("${cloud.aws.s3.bucket}")
    private String bucketName;

    private static final String SPLITER = "/";

    private final AmazonS3Client amazonS3Client;

    public String uploadToS3(MultipartFile file, String fileName) throws IOException {
        long size = file.getSize();
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentType(file.getContentType());
        metadata.setContentLength(size);

        try {
            // S3 업로드
            amazonS3Client.putObject(
                    new PutObjectRequest(bucketName, fileName, file.getInputStream(), metadata)
                            .withCannedAcl(CannedAccessControlList.PublicRead)
            );
        } catch (IOException e) {
            throw new IOException(e.getMessage());
        }

        // URL 가져오기
        String imgUrl = amazonS3Client.getUrl(bucketName, fileName).toString();
        log.info("S3에 저장된 이미지 파일 url: {}", imgUrl);

        return imgUrl;
    }

    public String getFileNameFromUrl(String url) {
        return url.split(SPLITER)[3];
    }

    public String setFileName(Long id, MultipartFile file, StorageDomain imageDomain) {
        String fileName = id + "-" + imageDomain.getDomain() + "Image-" + LocalDateTime.now();
        fileName = fileName.replace(" ", "-").replace(":", "-").replace(".", "-") + ".";

        String extension = null;
        try {
            String contentType = file.getContentType();
            if (!contentType.startsWith("image")) {
                // content type 검사
                throw new InvalidObjectException("이미지 파일이 아닙니다.");
            }

            // 확장자명 설정
            extension = contentType.split(SPLITER)[1];
        } catch (Exception e) {
        }

        if (extension == null) {
            log.warn("파일의 형식이 존재하지 않습니다. 임의로 image/png 타입으로 설정합니다.");
            extension = "png";
        }
        fileName += extension;

        return fileName;
    }
}