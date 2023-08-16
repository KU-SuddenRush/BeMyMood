package ku.hackerthon.BeMyMood.service.moodboard;

import ku.hackerthon.BeMyMood.domain.member.Member;
import ku.hackerthon.BeMyMood.domain.moodboard.MoodBoard;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.MoodBoardPicture;
import ku.hackerthon.BeMyMood.domain.moodboard.picture.MoodBoardPictures;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.MoodBoardSticker;
import ku.hackerthon.BeMyMood.domain.moodboard.sticker.MoodBoardStickers;
import ku.hackerthon.BeMyMood.domain.moodboard.text.MoodBoardText;
import ku.hackerthon.BeMyMood.domain.moodboard.text.MoodBoardTexts;
import ku.hackerthon.BeMyMood.domain.review.Review;
import ku.hackerthon.BeMyMood.dto.moodboard.*;
import ku.hackerthon.BeMyMood.dto.storage.StorageDomain;
import ku.hackerthon.BeMyMood.dto.web.request.MoodBoardRequestDto;
import ku.hackerthon.BeMyMood.dto.web.response.ReviewImagesResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.SpotSignatureImagesResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.MoodBoardDetailResponseDto;
import ku.hackerthon.BeMyMood.dto.web.response.MoodBoardResponseDto;
import ku.hackerthon.BeMyMood.service.spot.SpotService;
import ku.hackerthon.BeMyMood.service.storage.StorageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
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
                    requestDto.getMoodBoardName(),
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
                                pictureParam.getImgItemUrl(),
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

    @Override
    public MoodBoardResponseDto getAllMoodBoards(Member member) {
        List<MoodBoard> allMoodBoards = member.getMoodBoards().getAllMoodBoards();

        return new MoodBoardResponseDto(
                allMoodBoards.stream()
                        .map(moodBoard -> new MoodBoardInfo(
                                moodBoard.getId(),
                                moodBoard.getName(),
                                moodBoard.getCaptureImgUrl()
                        )).collect(Collectors.toList()));

    }

    @Override
    public MoodBoardInfo getLastEditedMoodBoard(Member member) {
        MoodBoard moodBoard = member.getMoodBoards().getLastEditedMoodBoard();

        return new MoodBoardInfo(
                moodBoard.getId(),
                moodBoard.getName(),
                moodBoard.getCaptureImgUrl()
        );
    }

    @Override
    public SpotSignatureImagesResponseDto getSpotSignatureImages(Member member) {
        List<Review> allOpenReviews = member.getReviews().getAllReview().stream()
                .filter(review -> review.isOpen())
                .collect(Collectors.toList());

        return new SpotSignatureImagesResponseDto(
                allOpenReviews.stream()
                        .map(review -> new SpotSignatureImageParams(
                                review.getSpot().getSpotImages().getMainImage().getId(),
                                review.getSpot().getSpotImages().getMainImage().getImgUrl()
                        )).collect(Collectors.toList()));
    }

    @Override
    public ReviewImagesResponseDto getReviewImages(Member member) {
        List<ReviewImageParams> allReviewImages = member.getReviews().getReviewImgs();
        return new ReviewImagesResponseDto(allReviewImages.size(), allReviewImages);
    }

    @Override
    public MoodBoardDetailResponseDto getMoodBoardDetail(MoodBoard moodBoard) {
        MoodBoardDetailResponseDto moodBoardDetail = new MoodBoardDetailResponseDto(
                moodBoard.getId(),
                moodBoard.getName()
        );

        List<MoodBoardPicture> allPictures = moodBoard.getPictures().getAllPictures();
        List<MoodBoardSticker> allStickers = moodBoard.getStickers().getAllStickers();
        List<MoodBoardText> allTexts = moodBoard.getTexts().getAllTexts();

        for (MoodBoardPicture picture : allPictures) {
            moodBoardDetail.getPictures().add(
                    new BoardPictureDetailParams(
                            //picture.getId(),
                            //picture.getSpotImage().getImgUrl(),
                            picture.getImgItemUrl(),
                            picture.getLocationX(),
                            picture.getLocationY(),
                            picture.getWidth(),
                            picture.getHeight(),
                            picture.getRotation()
                    )
            );
        }

        for (MoodBoardSticker sticker : allStickers) {
            moodBoardDetail.getStickers().add(
                    new BoardStickerParams(
                            sticker.getStickerId(),
                            sticker.getLocationX(),
                            sticker.getLocationY(),
                            sticker.getWidth(),
                            sticker.getHeight(),
                            sticker.getRotation()
                    )
            );
        }

        for (MoodBoardText text : allTexts) {
            moodBoardDetail.getTexts().add(
                    new BoardTextParams(
                            text.getLocationX(),
                            text.getLocationY(),
                            text.getFontSize(),
                            text.getFontColor(),
                            text.getSort(),
                            text.getContents()
                    )
            );
        }

        return moodBoardDetail;
    }

}
