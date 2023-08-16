//
//  MoodBoardLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//


import UIKit
import Then
import SnapKit

extension MoodBoardViewController {
    
    func hierarchy(){
        self.view.addSubview(moodBoardTitle)
        self.view.addSubview(slidingTabVC.view)
    }
    
    func layout(){
        moodBoardTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(73)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        slidingTabVC.view.snp.makeConstraints{ make in
            make.top.equalTo(moodBoardTitle.snp.bottom).offset(23)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
