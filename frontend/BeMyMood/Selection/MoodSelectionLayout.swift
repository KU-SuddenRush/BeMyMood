//
//  MoodSelectionLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/09.
//


import UIKit
import Then
import SnapKit

extension MoodSelectionViewController {
    
    func hierarchy(){
        self.view.addSubview(progressBar)
        self.view.addSubview(label)
        self.view.addSubview(collectionView)
        self.view.addSubview(nextBtn)
    }
    
    func layout(){
                
        progressBar.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(4)
        }
        
        label.snp.makeConstraints{ make in
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(label.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.bottom.equalToSuperview().offset(-124)
        }
        
        nextBtn.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(62)
        }

    }
}

