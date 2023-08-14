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
        self.view.addSubview(collectionView)
        self.view.addSubview(star1)
        self.view.addSubview(star2)
    }
    
    func layout(){
        logo.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(122)
            make.height.equalTo(24)
        }
        
        notificationBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(logo)
            make.trailing.equalToSuperview().offset(-24)
            make.width.height.equalTo(24)
        }
        
        introduce.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.leading.equalTo(logo.snp.leading)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(introduce.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(100)
        }
        
        star1.snp.makeConstraints{ make in
            make.top.equalTo(collectionView.snp.top).offset(-14)
            make.trailing.equalTo(collectionView.snp.trailing).offset(3)
            make.height.width.equalTo(28)
        }
        
        star2.snp.makeConstraints{ make in
            make.bottom.equalTo(collectionView.snp.bottom).offset(5)
            make.leading.equalTo(collectionView.snp.leading).offset(5)
            make.height.width.equalTo(28)
        }
    }
}
