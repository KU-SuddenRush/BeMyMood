//
//  HomeLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit
import Then
import SnapKit

extension HomeViewController {
    
    func hierarchy(){
        self.view.addSubview(logo)
        self.view.addSubview(notificationBtn)
        self.view.addSubview(introduce)
    }
    
    func layout(){
        logo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(122)
            make.height.equalTo(20)
        }
        
        notificationBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(68)
            make.trailing.equalToSuperview().offset(-24)
            make.width.height.equalTo(24)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.leading.equalTo(logo.snp.leading)
        }
    }
}
