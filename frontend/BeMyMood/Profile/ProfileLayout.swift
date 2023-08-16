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
        self.view.addSubview(mypage)
        self.view.addSubview(profile)
        self.view.addSubview(name)
        self.view.addSubview(myMood)
        self.view.addSubview(moodBtn)
        self.view.addSubview(line1)
        self.view.addSubview(detailBtn)
        self.view.addSubview(myBadge)
        self.view.addSubview(line2)
        self.view.addSubview(badge1)
        self.view.addSubview(badge2)
        self.view.addSubview(badge3)
        self.view.addSubview(line3)
        self.view.addSubview(myRecord)
        self.view.addSubview(mySpot)
        
    }
    
    func layout(){
        mypage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(73)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        profile.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(36)
        }
        
        name.snp.makeConstraints{ make in
            make.top.equalTo(profile)
            make.leading.equalTo(profile.snp.trailing).offset(16)
            make.height.equalTo(36)
        }
        myMood.snp.makeConstraints{ make in
            make.top.equalTo(profile.snp.bottom).offset(56.5)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(27)
        }
        moodBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(myMood)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(25)
            make.width.equalTo(93)
        }
        line1.snp.makeConstraints{ make in
            make.top.equalTo(myMood.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        detailBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(myBadge)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
            make.width.equalTo(74)
        }
        myBadge.snp.makeConstraints{ make in
            make.top.equalTo(line1.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(27)
        }
        badge1.snp.makeConstraints{ make in
            make.top.equalTo(myBadge.snp.bottom).offset(19.25)
            make.leading.equalToSuperview().offset(27.5)
            make.height.equalTo(113.75)
            make.width.equalTo(100)
        }
        badge2.snp.makeConstraints{ make in
            make.top.equalTo(myBadge.snp.bottom).offset(19.25)
            make.centerX.equalToSuperview()
            make.height.equalTo(113.75)
            make.width.equalTo(100)
        }
        badge3.snp.makeConstraints{ make in
            make.top.equalTo(myBadge.snp.bottom).offset(19.25)
            make.trailing.equalToSuperview().offset(-27.5)
            make.height.equalTo(113.75)
            make.width.equalTo(100)
        }
        line2.snp.makeConstraints{ make in
            make.top.equalTo(badge3.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        myRecord.snp.makeConstraints{ make in
            make.top.equalTo(line2.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(27)
        }
        line3.snp.makeConstraints{ make in
            make.top.equalTo(myRecord.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        mySpot.snp.makeConstraints{ make in
            make.top.equalTo(line3.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(27)
        }
    }
}
