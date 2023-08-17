//
//  RecordLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/12.

//
import UIKit
import Then
import SnapKit

extension RecordViewController {
    
    func hierarchy(){
        self.view.addSubview(closeBtn)
        self.view.addSubview(name)
        self.view.addSubview(myRecordOpenTitle)
        self.view.addSubview(openDescription)
        self.view.addSubview(slash)
        self.view.addSubview(recordTitle)
        self.view.addSubview(recordTextView)
        self.view.addSubview(photoBtn)
        self.view.addSubview(completeBtn)
        self.view.addSubview(publicSwitchView)
        self.view.addSubview(privateBtn)
        self.view.addSubview(recordPictureCollectionView)
        self.view.addSubview(publicBtn)
    }
    
    func layout(){
        
        closeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        name.snp.makeConstraints{ make in
            make.centerY.equalTo(closeBtn)
            make.leading.equalTo(closeBtn.snp.trailing).offset(10)
            make.height.equalTo(24)
        }
        
        myRecordOpenTitle.snp.makeConstraints{ make in
            make.top.equalTo(name.snp.bottom).offset(38)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
        
        publicSwitchView.snp.makeConstraints{ make in
            make.centerY.equalTo(myRecordOpenTitle)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(125)
            make.height.equalTo(32)
        }
        
        publicBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(publicSwitchView)
            make.leading.equalTo(publicSwitchView.snp.leading).offset(3)
            make.height.equalTo(26)
            make.width.equalTo(57)
        }
        
        privateBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(publicSwitchView)
            make.trailing.equalTo(publicSwitchView.snp.trailing).offset(-3)
            make.height.equalTo(26)
            make.width.equalTo(69)
        }
        
        openDescription.snp.makeConstraints{ make in
            make.top.equalTo(myRecordOpenTitle.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(42)
        }
        
        slash.snp.makeConstraints{ make in
            make.top.equalTo(openDescription.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
        }
        
        recordTitle.snp.makeConstraints{ make in
            make.top.equalTo(slash.snp.bottom).offset(14)
            make.leading.equalTo(slash.snp.leading)
            make.height.equalTo(24)
        }
        
        recordTextView.snp.makeConstraints{ make in
            make.top.equalTo(recordTitle.snp.bottom).offset(8)
            make.leading.equalTo(slash.snp.leading)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(220)
        }
        
        photoBtn.snp.makeConstraints{ make in
            make.top.equalTo(recordTextView.snp.bottom).offset(14)
            make.leading.equalTo(recordTextView.snp.leading)
            make.width.height.equalTo(110)
        }
        
        recordPictureCollectionView.snp.makeConstraints{ make in
            make.centerY.equalTo(photoBtn)
            make.leading.equalTo(photoBtn.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(110)
            
        }
        
        completeBtn.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(62)
        }
    }
}
