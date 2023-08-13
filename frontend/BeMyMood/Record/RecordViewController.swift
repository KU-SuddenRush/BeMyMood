//
//  RecordViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/12.
//

import UIKit
import Then
import SnapKit
import SwiftUI
import PhotosUI
import Kingfisher

class RecordViewController: UIViewController{

    var isPublic = true
    
    var deletePictureIndex = -1
    
    var imageData : [UIImage?] = [UIImage(named: "badge_empty"),UIImage(named: "home"),UIImage(named: "home_select")]
    
    //MARK: - UIComponents
    
    let closeBtn = UIButton().then{
        $0.setImage(UIImage(named: "close"), for: .normal)
    }
    
    let name = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "누데이크 성수점"
    }
    
    let myRecordOpenTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
        $0.text = "내 기록 공개하기"
    }
    
    let publicSwitchView = UIView().then{
        $0.backgroundColor = .darkBrown
        $0.layer.cornerRadius = 32/2
    }
    
    let publicBtn = UIButton().then{
        $0.setTitle("공개", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 26/2
    }
    
    let privateBtn = UIButton().then{
        $0.setTitle("비공개", for: .normal)
        $0.backgroundColor = .darkBrown
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 26/2
    }
    
    let openDescription = UILabel().then{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        $0.attributedText = NSMutableAttributedString(string: "공개 시 리뷰로 등록이 되며, 무드보드를 꾸밀 해당 스팟의\n시그니처 아이템이 제공됩니다.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 2
        $0.textColor = .darkBrown_80
    }
    
    let slash = UIImageView().then{
        $0.image = UIImage(named: "slash")
    }
    
    let recordTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
        $0.text = "이곳에서의 경험은 어땠나요?"
    }
    
    let recordTextViewPlaceHolder = "기록을 남겨주세요"
    
    let recordTextView = UITextView().then{
        $0.backgroundColor = .grayBeige
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor.darkBrown
        $0.text = "기록을 남겨주세요"
        $0.layer.cornerRadius = 15
        $0.textContainerInset = UIEdgeInsets(top: 18, left: 15, bottom: 18, right: 15)
    }
    
    let photoBtn = UIButton().then{
        $0.layer.borderColor = UIColor.darkBrown.cgColor
        $0.layer.borderWidth = 1
        $0.setTitle("사진 (0/5)", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.layer.cornerRadius = 15
        
        let iconImage = UIImage(named: "photoIcon")
            $0.setImage(iconImage, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: -35, left: 45, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -35, right: 18)
    }
    
    let recordPictureCollectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.showsHorizontalScrollIndicator = false
        $0.allowsSelection = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(RecordPictureCell.self, forCellWithReuseIdentifier: RecordPictureCell.cellIdentifier)
    }
    
    let completeBtn = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .darkBrown_30
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        //collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        self.recordPictureCollectionView.collectionViewLayout = layout
        self.recordPictureCollectionView.dataSource = self
        self.recordPictureCollectionView.delegate = self
        
        //textView
        self.recordTextView.delegate = self
        
        //Button
        self.photoBtn.setTitle("사진 (" + String(self.imageData.count) + "/5)", for: .normal)
        self.closeBtn.addTarget(self, action: #selector(closeBtnDidTab), for: .touchUpInside)
        self.publicBtn.addTarget(self, action: #selector(isPublicSwitch), for: .touchUpInside)
        self.privateBtn.addTarget(self, action: #selector(isPublicSwitch), for: .touchUpInside)
        self.photoBtn.addTarget(self, action: #selector(pictureUploadBtnTap), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    @objc func nextBtnDidTab() {
        let colorSelectionViewController = ColorSelectionViewController()
        self.navigationController?.pushViewController(colorSelectionViewController, animated: true)
        
    }
    
    @objc func closeBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deletePictureBtnDidTab(_ sender: UIButton) {

        self.imageData.remove(at: sender.tag)
        self.photoBtn.setTitle("사진 (" + String(self.imageData.count) + "/5)", for: .normal)
        self.recordPictureCollectionView.reloadData()
    }
    
    @objc func isPublicSwitch() {
        if isPublic {
            self.view.addSubview(privateBtn)
            self.privateBtn.setTitleColor(.darkBrown, for: .normal)
            self.privateBtn.backgroundColor = .white
            self.publicBtn.setTitleColor(.white, for: .normal)
            self.publicBtn.backgroundColor = .darkBrown
            isPublic.toggle()
        }else{
            self.view.addSubview(publicBtn)
            self.publicBtn.setTitleColor(.darkBrown, for: .normal)
            self.publicBtn.backgroundColor = .white
            self.privateBtn.setTitleColor(.white, for: .normal)
            self.privateBtn.backgroundColor = .darkBrown
            isPublic.toggle()
        }
    }
    
    @objc func pictureUploadBtnTap(_ sender: Any) {
        
        if (5-imageData.count)<=0{
            let alert = UIAlertController(title: nil, message: "5개까지 업로드 할 수 있습니다", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                print("확인 버튼이 눌렸습니다.")
            }
            alert.addAction(confirmAction)
            
            // 알림창 표시
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

            let galleryAction =  UIAlertAction(title: "사진첩에서 선택", style: UIAlertAction.Style.default){ [weak self] _ in
                if #available(iOS 14.0, *) {
                    self?.presentImagePicker()
                }else{
                    self?.pictureUploadByGallery()
                }
            }
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)

            //메시지 창 컨트롤러에 버튼 액션을 추가
            alert.addAction(galleryAction)
            alert.addAction(cancelAction)

            //메시지 창 컨트롤러를 표시
            self.present(alert, animated: true)
        }
        
        
    }
    
    //MARK: - Helpers

}

//MARK: - PhotoSelectDelegate
extension RecordViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate{
    
    // Use Photo Btn
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageData.append(image)
            photoBtn.setTitle("사진 (" + String( imageData.count) + "/5)", for: .normal)
            
            self.recordPictureCollectionView.reloadData()
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // cancel Btn
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 사진첩 선택 (ios 13 ~)
    func pictureUploadByGallery(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @available(iOS 14.0, *)
    func presentImagePicker() {
        // configuration 정의
        var config = PHPickerConfiguration()
        
        config.selectionLimit = 5 - imageData.count
        print("config.selectionLimit")
        print(config.selectionLimit)
        
        if #available(iOS 15.0, *) {
            config.filter = .any(of: [.images, .screenshots])
        } else {
            config.filter = .any(of: [.images]) // images 에 live photos 포함
        }
        
        // picker Present
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        // 이미지 처리 로직 추가
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    DispatchQueue.main.async {
                        if let image = image as? UIImage {
                            self?.imageData.append(image)
                            self?.photoBtn.setTitle("사진 (" + String( self?.imageData.count ?? 0) + "/5)", for: .normal)
                            
                            self?.recordPictureCollectionView.reloadData()
                            
                        }
                    }
                }
            }
        }
    }
}

    //MARK: - CollectionViewDelegate
extension RecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageData.isEmpty{
            return 0
        }else {
            return imageData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordPictureCell.cellIdentifier, for: indexPath) as? RecordPictureCell else{
            fatalError()
        }
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        cell.recordImage.image = imageData[indexPath.row]
        cell.contentMode = .scaleAspectFit
        
        cell.removeBtn.tag = indexPath.row
        cell.removeBtn.addTarget(self, action: #selector(deletePictureBtnDidTab(_:)), for: .touchUpInside)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordPictureCell.cellIdentifier, for: indexPath) as? RecordPictureCell else{
            fatalError()
        }

        let size = CGSize(width: 110, height: 110)
        
        return size
    }
}

    //MARK: - TextViewDelegate
extension RecordViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.recordTextView.text == self.recordTextViewPlaceHolder {
            self.recordTextView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if self.recordTextView.text == "" {
            self.recordTextView.text = self.recordTextViewPlaceHolder
        }
    }

//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
//        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let characterCount = newString.count
//        guard characterCount <= 700 else { return false }
//        updateCountLabel(characterCount: characterCount)
//
//        return true
//    }
}

struct RecordVCPreView:PreviewProvider {
    static var previews: some View {
        RecordViewController().toPreview()
    }
}
