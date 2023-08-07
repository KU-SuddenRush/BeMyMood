//
//  ProfileLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit
import Then
import SnapKit

extension ProfileViewController {
    
    func hierarchy(){
        self.view.addSubview(nextButton)
    }
    
    func layout(){
        nextButton.snp.makeConstraints{ make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
    }
}
