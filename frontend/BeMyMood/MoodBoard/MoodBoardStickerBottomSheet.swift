//
//  MoodBoardStickerBottomSheet.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/15.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class MoodBoardStickerBottomSheet: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    let stickerData = UIImage.stickers
    
    weak var delegate: StickerDelegate?
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!

    // MARK: - UIComponents

    let dimmedBackView = UIView().then {
        $0.backgroundColor = .clear
    }

    // 바텀 시트 뷰
    let bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    let stickerTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .white
        $0.text = "꾸미기"
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(StickerCell.self, forCellWithReuseIdentifier: StickerCell.cellIdentifier)
    }
    

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        setupGestureRecognizer()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
        
        setupGestureRecognizerOnCollection()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        showBottomSheet()
    }


    // MARK: - @Functions
    private func hierarchy() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        bottomSheetView.addSubview(stickerTitle)
        bottomSheetView.addSubview(collectionView)

        dimmedBackView.alpha = 0
        layout()
        
    }

    // 레이아웃 세팅
    private func layout() {
        dimmedBackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.backgroundColor = UIColor(hex: "#0000000", alpha: 0.4)
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint
        ])
        
        stickerTitle.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(24)
            make.centerX.equalTo(bottomSheetView)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(stickerTitle.snp.bottom).offset(52)
            make.leading.trailing.bottom.equalTo(bottomSheetView)
        }
        
        

    }

    //MARK: - Actions

    @objc func timecompleteBtnDidTap() {
        hideBottomSheetAndGoBack()
    }
    
    //스티커뷰 선택 제스쳐
    func setupGestureRecognizerOnCollection() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSticker(gestureRecognizer:)))
        tapGesture.delegate = self
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapSticker(gestureRecognizer: UIGestureRecognizer) {

        let p = gestureRecognizer.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: p) {
            delegate?.didAddSticker(tag: indexPath.row)
            dismiss(animated: true, completion: nil)
        }
    }

    //MARK: - Helpers

    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom

        bottomSheetViewTopConstraint.constant = 226

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    // GestureRecognizer 세팅 작업
    private func setupGestureRecognizer() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true

        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }


    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }

    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}

//MARK: - CollectionViewDelegate

extension MoodBoardStickerBottomSheet: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if stickerData.isEmpty{
        return 0
    }else {
        return stickerData.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCell.cellIdentifier, for: indexPath) as? StickerCell else{
        fatalError()
    }
    
    cell.sticker.image = stickerData[indexPath.row]
    
    return cell
}

//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCell.cellIdentifier, for: indexPath) as? StickerCell else{
//        fatalError()
//    }
//    
//    
//}
//
//func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCell.cellIdentifier, for: indexPath) as? StickerCell else{
//        fatalError()
//    }
//}
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 116, height: 139)
        
        return size
    }
}
