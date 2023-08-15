//
//  SignUpModal.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class SignUpModal: UIViewController {


    // MARK: - Properties

    var signupVCNavigationController : UINavigationController!

    // MARK: - UIComponents

    let dimmedBackView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    // 바텀 시트 뷰
    let bottomSheetView = UIImageView().then {
        $0.image = UIImage(named: "signUpComplete")
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    let startBtn = UIButton().then{
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = .darkBrown
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 47/2
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        self.startBtn.addTarget(self, action: #selector(startBtnDidTab), for: .touchUpInside)
    }

    // MARK: - @Functions
    private func hierarchy() {
        view.addSubview(dimmedBackView)
        view.addSubview(bottomSheetView)
        view.addSubview(startBtn)

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
        bottomSheetView.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(325)
            make.height.equalTo(320)
        }
        
        startBtn.snp.makeConstraints{ make in
            make.bottom.equalTo(bottomSheetView.snp.bottom).offset(-30)
            make.leading.equalTo(bottomSheetView.snp.leading).offset(66)
            make.trailing.equalTo(bottomSheetView.snp.trailing).offset(-66)
            make.height.equalTo(47)
        }

    }

    //MARK: - Actions

    //MARK: - Helpers
    @objc func startBtnDidTab() {
        self.dismiss(animated: false, completion: nil)
        let homeVC = TabBarController()
        self.signupVCNavigationController?.pushViewController(homeVC, animated: true)
        
    }
}
