package ku.hackerthon.BeMyMood.service.moodboard;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.MoodBoardPicture;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.MoodBoardPictures;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.MoodBoardSticker;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.MoodBoardStickers;
import ku.hackerthon.BeMyMood.domain.moodboard.text.MoodBoardText;
import ku.hackerthon.BeMyMood.domain.moodboard.text.MoodBoardTexts;
import ku.hackerthon.BeMyMood.dto.moodboard.BoardPictureParams;
import ku.hackerthon.BeMyMood.dto.moodboard.BoardStickerParams;
import ku.hackerthon.BeMyMood.dto.moodboard.BoardTextParams;
import ku.hackerthon.BeMyMood.dto.storage.StorageDomain;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import ku.hackerthon.BeMyMood.service.storage.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class MoodBoardServiceImpl implements MoodBoardService {
    private final StorageService storageService;
    private final SpotService spotService;

    @Override
    public void moodBoard(Member member, MultipartFile file, MoodBoardRequestDto requestDto) {
        String fileName = storageService.setFileName(member.getId(), file, StorageDomain.MOODBOARD);
        try {
            // 무드보드 생성
            String uploadUrl = storageService.uploadToS3(file, fileName);
            MoodBoard moodBoard = new MoodBoard(
                    member,
                    uploadUrl
            );

            MoodBoardPictures pictures = moodBoard.getPictures();
            MoodBoardStickers stickers = moodBoard.getStickers();
            MoodBoardTexts texts = moodBoard.getTexts();

            // 무드보드 요소 저장 - 사진(스팟 시그니처) / 스티커 / 텍스트
            // 사진
            List<BoardPictureParams> pictureParams = requestDto.getPictures();
            for (BoardPictureParams pictureParam : pictureParams) {
                pictures.add(
                        new MoodBoardPicture(
                                moodBoard,
                                spotService.searchSpotImgById(pictureParam.getSpotImgId()),
                                pictureParam.getLocationX(),
                                pictureParam.getLocationY(),
                                pictureParam.getWidth(),
                                pictureParam.getHeight(),
                                pictureParam.getRotation()
                        ));
            }

            // 스티커
            List<BoardStickerParams> stickerParams = requestDto.getStickers();
            for (BoardStickerParams stickerParam : stickerParams) {
                stickers.add(
                        new MoodBoardSticker(
                                moodBoard,
                                stickerParam.getStickerId(),
                                stickerParam.getLocationX(),
                                stickerParam.getLocationY(),
                                stickerParam.getWidth(),
                                stickerParam.getHeight(),
                                stickerParam.getRotation()
                        ));
            }

            // 텍스트
            List<BoardTextParams> textParams = requestDto.getTexts();
            for (BoardTextParams textParam : textParams) {
                texts.add(
                        new MoodBoardText(
                                moodBoard,
                                textParam.getLocationX(),
                                textParam.getLocationY(),
                                textParam.getFontSize(),
                                textParam.getFontColor(),
                                textParam.getSort(),
                                textParam.getContents()
                        ));
            }

        } catch (IOException e) {
            throw new RuntimeException("S3 업로드 실패");
        }
    }

}
