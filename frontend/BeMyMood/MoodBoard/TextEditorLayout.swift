//
//  TextEditorLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/15.
//
import UIKit
import Then
import SnapKit

extension TextEditorViewController {
    
    func hierarchy(){
        self.view.addSubview(closeBtn)
        self.view.addSubview(textView)
        self.view.addSubview(textSizeBar)
        self.view.addSubview(textSizeEditIcon)
        self.view.addSubview(textAlignmentBtn)
        self.view.addSubview(textColorBtn)
    }
    
    func layout(){
        closeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(32)
            make.height.equalTo(27)
        }
        
        textView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }
        
        textAlignmentBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(59)
            make.width.height.equalTo(28)
        }
        
        textColorBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(59)
            make.width.height.equalTo(28)
        }
        
        textSizeBar.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(280)
            make.leading.equalToSuperview().offset(18)
            make.width.equalTo(12)
            make.height.equalTo(180)
        }
        
        textSizeEditIcon.snp.makeConstraints{ make in
            make.centerX.centerY.equalTo(textSizeBar)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
}
