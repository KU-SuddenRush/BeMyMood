//
//  LoginLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit

extension LoginViewController {
    
    func hierarchy(){
        self.view.addSubview(logo)
        self.view.addSubview(email)
        self.view.addSubview(password)
        self.view.addSubview(loginBtn)
        self.view.addSubview(signUpBtn)
    }
    
    func layout(){
        logo.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(316)
        }
        email.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(190)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(46)
        }
        password.snp.makeConstraints{ make in
            make.top.equalTo(email.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(46)
        }
        loginBtn.snp.makeConstraints{ make in
            make.top.equalTo(password.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(62)
        }
        
        signUpBtn.snp.makeConstraints{ make in
            make.top.equalTo(loginBtn.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(24)
        }

    }
}
