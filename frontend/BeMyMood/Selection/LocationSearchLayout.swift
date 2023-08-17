//
//  EachLocationSelectionLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/13.
//

import UIKit
import Then
import SnapKit

extension LocationSearchViewController {
    
    func hierarchy(){
        self.view.addSubview(closeBtn)
        self.view.addSubview(label)
        self.view.addSubview(searchBar)
        self.view.addSubview(resultLabel)
        self.view.addSubview(collectionView)
    }
    
    func layout(){
                
        closeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(24)
        }
        
        label.snp.makeConstraints{ make in
            make.centerY.equalTo(closeBtn)
            make.leading.equalTo(closeBtn.snp.trailing).offset(10)
            make.height.equalTo(30)
        }
        
        searchBar.snp.makeConstraints{ make in
            make.top.equalTo(label.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(31)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(resultLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(31)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }
}
