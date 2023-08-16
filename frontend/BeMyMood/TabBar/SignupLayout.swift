//
//  SignupLayout.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit

extension SignupViewController {
    
    func hierarchy(){
        self.view.addSubview(signUpTitle)
        self.view.addSubview(nameLabel)
        self.view.addSubview(name)
        self.view.addSubview(emailLabel)
        self.view.addSubview(email)
        self.view.addSubview(passwordLabel)
        self.view.addSubview(password)
        self.view.addSubview(passwordCheck)
        self.view.addSubview(notice)
        self.view.addSubview(signUpBtn)
    }
    
    func layout(){
        signUpTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(79)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints{ make in
            make.top.equalTo(signUpTitle.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(24)
        }
        name.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(46)
        }
        emailLabel.snp.makeConstraints{ make in
            make.top.equalTo(name.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(24)
        }
        email.snp.makeConstraints{ make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(46)
        }
        passwordLabel.snp.makeConstraints{ make in
            make.top.equalTo(email.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(24)
        }
        password.snp.makeConstraints{ make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(46)
        }
        passwordCheck.snp.makeConstraints{ make in
            make.top.equalTo(password.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(46)
        }
        notice.snp.makeConstraints{ make in
            make.top.equalTo(passwordCheck.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(32)
        }
        
        signUpBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(62)
        }

    }
}
