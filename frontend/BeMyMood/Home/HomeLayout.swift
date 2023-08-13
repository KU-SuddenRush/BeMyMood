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
        self.view.addSubview(homeTitle)
        self.view.addSubview(notificationBtn)
        self.view.addSubview(moodCount)
        self.view.addSubview(collectionView)
        self.view.addSubview(badgeCount)
        self.view.addSubview(badgeBtn)
        self.view.addSubview(badgeLabel)
        self.view.addSubview(star1)
        self.view.addSubview(star2)
        self.view.addSubview(star3)
    }
    
    func layout(){
        homeTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(19)
            make.height.equalTo(30)
        }
        
        notificationBtn.snp.makeConstraints{ make in
            make.top.equalTo(homeTitle.snp.top)
            make.trailing.equalToSuperview().offset(-24)
            make.width.height.equalTo(24)
        }
        
        moodCount.snp.makeConstraints{ make in
            make.top.equalTo(homeTitle.snp.bottom).offset(19)
            make.leading.equalTo(homeTitle.snp.leading)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(moodCount.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(200)
            make.height.equalTo(145)
        }
        
        badgeCount.snp.makeConstraints{ make in
            make.top.equalTo(moodCount)
            make.leading.equalTo(collectionView.snp.trailing).offset(17)
        }
        
        badgeBtn.snp.makeConstraints{ make in
            make.top.equalTo(badgeCount.snp.bottom).offset(8)
            make.leading.equalTo(badgeCount.snp.leading)
            make.width.equalTo(125)
            make.height.equalTo(160)
        }
        
        badgeLabel.snp.makeConstraints{ make in
            make.top.equalTo(badgeBtn.snp.top).offset(21)
            make.leading.equalTo(badgeBtn.snp.leading).offset(15)
        }
        
        star1.snp.makeConstraints{ make in
            make.top.equalTo(collectionView.snp.top).offset(-10)
            make.leading.equalTo(collectionView.snp.leading).offset(-7)
            make.height.width.equalTo(26)
        }
        
        star2.snp.makeConstraints{ make in
            make.bottom.equalTo(badgeBtn.snp.bottom).offset(13)
            make.leading.equalTo(badgeBtn.snp.leading).offset(15)
            make.height.width.equalTo(26)
        }
        
        star3.snp.makeConstraints{ make in
            make.bottom.equalTo(badgeBtn.snp.bottom).offset(-36)
            make.trailing.equalTo(badgeBtn.snp.trailing).offset(5)
            make.height.width.equalTo(26)
        }
    }
}
