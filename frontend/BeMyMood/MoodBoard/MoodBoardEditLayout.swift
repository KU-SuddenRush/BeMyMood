//
//  MoodBoardEditLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/14.
//

//
//  LocationSelectionLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/09.
//

import UIKit
import Then
import SnapKit

extension MoodBoardEditViewController {
    
    func hierarchy(){
        self.view.addSubview(closeBtn)
        self.view.addSubview(drawBtn)
        self.view.addSubview(textBtn)
        self.view.addSubview(stickerBtn)
        self.view.addSubview(photoBtn)
        self.view.addSubview(backgroundColorBtn)
        self.view.addSubview(nextBtn)
        self.view.addSubview(colorCollectionView)
    }
    
    func layout(){
        
        closeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(24)
        }
        
        drawBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-24)
            make.width.height.equalTo(28)
        }
        
        textBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalTo(drawBtn.snp.leading).offset(-10)
            make.width.height.equalTo(28)
        }
        
        stickerBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalTo(textBtn.snp.leading).offset(-10)
            make.width.height.equalTo(28)
        }
        
        photoBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalTo(stickerBtn.snp.leading).offset(-14.89)
            make.width.height.equalTo(28)
        }
        
        backgroundColorBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalTo(photoBtn.snp.leading).offset(-14.89)
            make.width.height.equalTo(28)
        }
        
        
        
        nextBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-45)
            make.height.equalTo(47)
            make.width.equalTo(162)
        }
        
        colorCollectionView.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-45)
            make.trailing.equalToSuperview()
            make.height.equalTo(28)
        }

    }
}

