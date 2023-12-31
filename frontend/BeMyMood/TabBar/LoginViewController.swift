//
//  LoginViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class LoginViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let logo = UIImageView().then {
        $0.image = UIImage(named: "loginLogo")
        $0.contentMode = .scaleAspectFill
    }
    
    let email = UITextField().then{
        let placeholderText = "이메일을 입력해 주세요"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkBrown,
            .font: UIFont.systemFont(ofSize: 16) // 원하는 폰트와 사이즈로 설정
        ]
        $0.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 46/2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: $0.frame.size.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.returnKeyType = .next
        $0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.enablesReturnKeyAutomatically = true
    }
    
    let password = UITextField().then{
        
        let placeholderText = "비밀번호를 입력해 주세요"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkBrown,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        $0.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 46/2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: $0.frame.size.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.returnKeyType = .done
        $0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.isSecureTextEntry = true
        $0.enablesReturnKeyAutomatically = true
    }
    
    let loginBtn = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .darkBrown
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }
    
    let signUpBtn = UIButton().then{
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.darkBrown_80, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .grayBeige
        
        hierarchy()
        layout()
        
        email.delegate = self
        password.delegate = self
        
        self.loginBtn.addTarget(self, action: #selector(loginBtnDidTab), for: .touchUpInside)
        self.signUpBtn.addTarget(self, action: #selector(signUpBtnDidTab), for: .touchUpInside)
        
        // 텍스트 필드의 텍스트 변경을 모니터링
        email.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // 초기 버튼 상태 설정
        updateLoginButtonState()
    }
    
    //MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.3){
            self.view.window?.frame.origin.y = 0
        }
    }
    
    @objc private func textFieldDidChange() {
        updateLoginButtonState()
    }
    // 로그인 버튼의 활성화 상태를 업데이트하는 메서드
    private func updateLoginButtonState() {
        let isEmailEmpty = email.text?.isEmpty ?? true
        let isPasswordEmpty = password.text?.isEmpty ?? true
        
        loginBtn.isEnabled = !isEmailEmpty && !isPasswordEmpty
        
        if loginBtn.isEnabled {
            loginBtn.backgroundColor = .darkBrown // 활성화된 경우 배경색을 파란색으로 설정
        } else {
            loginBtn.backgroundColor = .darkBrown_30 // 비활성화된 경우 배경색을 연한 회색으로 설정
        }
    }
    
    @objc func loginBtnDidTab() {
        ApiClient().login(self,LoginInput(email: email.text,password: password.text))
    }
    
    @objc func signUpBtnDidTab() {
        let signUpViewController = SignupViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}

//MARK: - Keyboard

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        } else {
            password.resignFirstResponder()
        }
        return true
    }
}

struct LoginVCPreView:PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
