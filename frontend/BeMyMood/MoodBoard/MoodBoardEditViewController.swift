//
//  MoodBoardEditViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/14.
//

import UIKit
import Then
import SnapKit
import SwiftUI
import StickerView
import Kingfisher

class MoodBoardEditViewController: UIViewController, TextEditorDelegate, UIGestureRecognizerDelegate {
    
    var selectColor = 0
    
    var _selectedStickerView:StickerView?
        var selectedStickerView:StickerView? {
            get {
                return _selectedStickerView
            }
            set {
                // if other sticker choosed then resign the handler
                if _selectedStickerView != newValue {
                    if let selectedStickerView = _selectedStickerView {
                        selectedStickerView.showEditingHandlers = false
                    }
                    _selectedStickerView = newValue
                }
                // assign handler to new sticker added
                if let selectedStickerView = _selectedStickerView {
                    selectedStickerView.showEditingHandlers = true
                    selectedStickerView.superview?.bringSubviewToFront(selectedStickerView)
                }
            }
        }
    
    func cancel(selected: Bool) {
        isStickerSelected = selected
        btnCheck()
    }
    
    func didAddSticker(tag: Int) {
        let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 116, height: 139))
        testImage.image = UIImage.stickers[tag]
        testImage.contentMode = .scaleToFill
        
        let sticker = StickerView.init(contentView: testImage)
        sticker.center = CGPoint.init(x: 150, y: 150)
        sticker.delegate = self
        sticker.setImage(UIImage.init(named: "deletePicture")!, forHandler: StickerViewHandler.close)
        sticker.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
        sticker.showEditingHandlers = false
        self.view.addSubview(sticker)
        self.selectedStickerView = sticker
        
        isStickerSelected = false
        btnCheck()
        
    }
    
    
    func didAddText(_ text: String, withStyle style: TextStyle) {
        let textView = UITextView().then{
            $0.font = style.font
            $0.text = text
            $0.textAlignment = style.alignment
            $0.backgroundColor = .clear
            $0.textColor = .white
            $0.sizeToFit()
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        textView.addGestureRecognizer(panGesture)
        
        view.addSubview(textView)
        
        selectedTextView = textView
        
        // 새로운 텍스트뷰를 배열에 추가
        textViews.append(textView)
        
        // 이전 텍스트뷰의 레이아웃을 변경하지 않고 새로운 텍스트뷰의 레이아웃을 설정
        selectedTextView.center = view.center
    }
    
    
    var textViews: [UITextView] = []
    var selectedTextView = UITextView()
    var isColorSelected = false
    var isStickerSelected = false
    
    //MARK: - UIComponents
    
    let closeBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    let drawBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "pencilIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    let textBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "textIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    let stickerBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "addStickerIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    let photoBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "photoIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    let backgroundColorBtn = UIButton().then{
        $0.setImage(UIImage(named: "color0"), for: .normal)
    }
    
    let nextBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .darkBrown_30
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 47/2
    }
    
    let colorCollectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .clear
        $0.isHidden = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellIdentifier)
        $0.isUserInteractionEnabled = true
        $0.allowsMultipleSelection = false
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .color0_1
        
        hierarchy()
        layout()
        
        //collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        self.colorCollectionView.collectionViewLayout = layout
        self.colorCollectionView.dataSource = self
        self.colorCollectionView.delegate = self
        
        //Button
        self.closeBtn.addTarget(self, action: #selector(closeBtnDidTab), for: .touchUpInside)
        
        self.backgroundColorBtn.addTarget(self, action: #selector(backgroundColorBtnDidTab), for: .touchUpInside)
        
        self.textBtn.addTarget(self, action: #selector(addTextButtonTapped), for: .touchUpInside)
        self.stickerBtn.addTarget(self, action: #selector(stickerBtnDidTab), for: .touchUpInside)
        self.photoBtn.addTarget(self, action: #selector(photoBtnDidTab), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        isColorSelected = false
        isStickerSelected = false
        
        btnCheck()
        
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        self.view.backgroundColor = UIColor.colorList[selectColor]
    }
    
    
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        selectedStickerView.hid
        UIView.animate(withDuration: 1){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    @objc func closeBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func backgroundColorBtnDidTab() {
        isColorSelected.toggle()
        
        btnCheck()
    }
    
    @objc func addTextButtonTapped() {
        let textInputVC = TextEditorViewController()
        textInputVC.delegate = self
        textInputVC.modalPresentationStyle = .overFullScreen
        present(textInputVC, animated: true, completion: nil)
    }
    
    @objc func stickerBtnDidTab() {
        isStickerSelected.toggle()
        
        btnCheck()
        
        let StickerBottomSheetVC = MoodBoardStickerBottomSheet()
        StickerBottomSheetVC.modalPresentationStyle = .overFullScreen
        StickerBottomSheetVC.delegate = self
        self.present(StickerBottomSheetVC, animated: false, completion: nil)
        
    }
    
    @objc func photoBtnDidTab() {
        let MoodBoardImageVC = MoodBoardImageViewController()
        MoodBoardImageVC.completionHandler = {url in
            var testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 125, height: 180))
            if let imageUrl = URL(string: url) {
                testImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "addMoodBoard"))
            }
            testImage.contentMode = .scaleToFill
            
            let sticker = StickerView.init(contentView: testImage)
            sticker.center = CGPoint.init(x: 150, y: 150)
            sticker.delegate = self
            sticker.setImage(UIImage.init(named: "deletePicture")!, forHandler: StickerViewHandler.close)
            sticker.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
            sticker.showEditingHandlers = false
            self.view.addSubview(sticker)
            self.selectedStickerView = sticker
        }
        self.navigationController?.pushViewController(MoodBoardImageVC, animated: true)
        
    }
    
    func btnCheck(){
        if isColorSelected && !isStickerSelected{
            nextBtn.isHidden = true
            colorCollectionView.isHidden = false
        }else if !isColorSelected && isStickerSelected{
            nextBtn.isHidden = true
            colorCollectionView.isHidden = true
        }else {
            nextBtn.isHidden = false
            colorCollectionView.isHidden = true
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let textView = gesture.view as? UITextView else {
            return
        }
        
        if gesture.state == .changed {
            let translation = gesture.translation(in: view)
            textView.center = CGPoint(x: textView.center.x + translation.x, y: textView.center.y + translation.y)
            gesture.setTranslation(.zero, in: view)
        }
    }
    
    //MARK: - StickerViewFunc
    

    
    
    //MARK: - Helpers
    func backgroundColorBtnStatus(){
        if backgroundColorBtn.currentImage == UIImage.colorIcon[3] || backgroundColorBtn.currentImage == UIImage.colorIcon[4] || backgroundColorBtn.currentImage == UIImage.colorIcon[6]{
            closeBtn.tintColor = .black
            drawBtn.tintColor = .black
            textBtn.tintColor = .black
            stickerBtn.tintColor = .black
            photoBtn.tintColor = .black
        }else {
            closeBtn.tintColor = .white
            drawBtn.tintColor = .white
            textBtn.tintColor = .white
            stickerBtn.tintColor = .white
            photoBtn.tintColor = .white
        }
    }

}

//MARK: - CollectionViewDelegate
extension MoodBoardEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if UIImage.colorIcon.isEmpty{
        return 0
    }else {
        return UIImage.colorIcon.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) as? ColorCell else{
        fatalError()
    }
    cell.colorBtn.image = UIImage.colorIcon[indexPath.row]
    cell.contentMode = .scaleAspectFit

    return cell
}


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else {
            fatalError()
        }
        cell.isSelected.toggle() // 셀의 isSelected 상태를 변경
        cell.row = indexPath.row
        self.view.backgroundColor = UIColor.colorList[indexPath.row]
        selectColor = indexPath.row
        self.backgroundColorBtn.setImage(UIImage.colorIcon[indexPath.row], for: .normal)
        backgroundColorBtnStatus()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else {
            fatalError()
        }
        cell.isSelected.toggle()
        cell.colorBtn.image = UIImage.colorIcon[indexPath.row]
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) is ColorCell else{
            fatalError()
        }

        let size = CGSize(width: 28, height: 28)
        
        return size
    }
}

protocol TextEditorDelegate: AnyObject {
    func didAddText(_ text: String, withStyle style: TextStyle)
}

protocol StickerDelegate: AnyObject {
    func didAddSticker(tag: Int)
    func cancel(selected: Bool)
}

struct TextStyle {
    var alignment: NSTextAlignment
    var font: UIFont
    var textColor: UIColor
}

struct Sticker {
    let stickerType: Int
    let sticker : StickerView
    var flip : Bool
}

extension MoodBoardEditViewController :StickerDelegate, StickerViewDelegate{
 
    
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {
    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
    }
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        if stickerView.showEditingHandlers == false {
            self.selectedStickerView = stickerView
            stickerView.showEditingHandlers = true
        }else {
            stickerView.showEditingHandlers = false
        }
    }
}

struct MoodBoardEditVCPreView:PreviewProvider {
    static var previews: some View {
        MoodBoardEditViewController().toPreview()
    }
}

