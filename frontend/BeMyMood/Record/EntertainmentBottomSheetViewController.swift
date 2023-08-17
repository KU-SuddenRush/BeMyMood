//
//  EntertainmentBottomSheetViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/13.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class EntertainmentBottomSheetViewController: UIViewController {


    // MARK: - Properties

    // 바텀 시트 높이
    let bottomHeight: CGFloat = 403

    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!

    // MARK: - UIComponents

    let dimmedBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    // 바텀 시트 뷰
    let bottomSheetView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    
    let entertainmentTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 1.2
        $0.attributedText = NSMutableAttributedString(string: "이곳의 즐길 거리가\n무엇인지 알려주세요!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.numberOfLines = 2
    }
    
    let dessertBtn = UIButton().then{
        $0.setTitle("디저트", for: .normal)
        $0.backgroundColor = UIColor(hex: "#f1f1f1")
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 56/2
        
        let iconImage = UIImage(named: "dessertIcon") // 원하는 아이콘 이미지로 변경
        $0.setImage(iconImage, for: .normal)
        $0.setImage(iconImage, for: .highlighted)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 아이콘 위치 조정
    }
    
    let drinkBtn = UIButton().then{
        $0.setTitle("음료", for: .normal)
        $0.backgroundColor = UIColor(hex: "#f1f1f1")
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 56/2
        
        let iconImage = UIImage(named: "drinkIcon") // 원하는 아이콘 이미지로 변경
        $0.setImage(iconImage, for: .normal)
        $0.setImage(iconImage, for: .highlighted)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 아이콘 위치 조정
    }
    
    let musicBtn = UIButton().then{
        $0.setTitle("음악", for: .normal)
        $0.backgroundColor = UIColor(hex: "#f1f1f1")
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 56/2
        
        let iconImage = UIImage(named: "musicIcon") // 원하는 아이콘 이미지로 변경
        $0.setImage(iconImage, for: .normal)
        $0.setImage(iconImage, for: .highlighted)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 아이콘 위치 조정
    }

    lazy var completeBtn = UIButton().then{
        $0.setTitle("리뷰로 등록", for: .normal)
        $0.backgroundColor = .darkBrown
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }
    
    let exhibitionBtn = UIButton().then{
        $0.setTitle("전시", for: .normal)
        $0.backgroundColor = UIColor(hex: "#f1f1f1")
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 56/2
        
        let iconImage = UIImage(named: "exhibitionIcon") // 원하는 아이콘 이미지로 변경
        $0.setImage(iconImage, for: .normal)
        $0.setImage(iconImage, for: .highlighted)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 아이콘 위치 조정
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        setupGestureRecognizer()
        completeBtn.addTarget(self, action: #selector(moveToHome), for: .touchUpInside)
    }
    
    @objc func moveToHome(){
        
        let nextVC = TabBarController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        showBottomSheet()
    }


    // MARK: - @Functions
    private func hierarchy() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        bottomSheetView.addSubview(entertainmentTitle)
        
        bottomSheetView.addSubview(dessertBtn)
        bottomSheetView.addSubview(drinkBtn)
        bottomSheetView.addSubview(musicBtn)
        bottomSheetView.addSubview(exhibitionBtn)
        
        bottomSheetView.addSubview(completeBtn)

        dimmedBackView.alpha = 0.5
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
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint
        ])
        
        entertainmentTitle.snp.makeConstraints{ make in
            make.top.equalTo(bottomSheetView.snp.top).offset(42)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(110)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-110)
            make.height.equalTo(54)
        }
        
        dessertBtn.snp.makeConstraints{ make in
            make.top.equalTo(entertainmentTitle.snp.bottom).offset(33)
            make.leading.equalTo(bottomSheetView.snp.centerX).offset(-295/2)
            make.width.equalTo(150)
            make.height.equalTo(56)
        }
        
        drinkBtn.snp.makeConstraints{ make in
            make.top.equalTo(dessertBtn)
            make.leading.equalTo(dessertBtn.snp.trailing).offset(12)
            make.width.equalTo(133)
            make.height.equalTo(56)
        }
        
        musicBtn.snp.makeConstraints{ make in
            make.top.equalTo(dessertBtn.snp.bottom).offset(18)
            make.leading.equalTo(dessertBtn)
            make.width.equalTo(133)
            make.height.equalTo(56)
        }
        
        exhibitionBtn.snp.makeConstraints{ make in
            make.top.equalTo(musicBtn)
            make.leading.equalTo(musicBtn.snp.trailing).offset(12)
            make.width.equalTo(133)
            make.height.equalTo(56)
        }

        completeBtn.snp.makeConstraints{ make in
            make.bottom.equalTo(bottomSheetView.snp.bottom).offset(-40)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(20)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-20)
            make.height.equalTo(62)
        }

    }

    //MARK: - Actions

    @objc func timecompleteBtnDidTap() {
        hideBottomSheetAndGoBack()
    }

    //MARK: - Helpers

    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom

        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight

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
