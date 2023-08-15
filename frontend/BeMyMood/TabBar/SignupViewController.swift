//
//  SignupViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//
import UIKit
import Then
import SnapKit
import SwiftUI

class SignupViewController: UIViewController {
    //MARK: - UIComponents
    
    let signUpTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "회원가입"
        $0.textAlignment = .center
    }
    
    let nameLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .darkBrown
        $0.text = "이름 *"
        if let text = $0.text, let lastCharacter = text.last {
            let attributedText = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: String(lastCharacter))
            attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: range) // 원하는 색상으로 설정
            $0.attributedText = attributedText
        }
    }
    
    let name = UITextField().then{
        let placeholderText = "이름을 입력해 주세요"
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
    }
    
    let emailLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .darkBrown
        $0.text = "이메일 *"
        if let text = $0.text, let lastCharacter = text.last {
            let attributedText = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: String(lastCharacter))
            attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: range) // 원하는 색상으로 설정
            $0.attributedText = attributedText
        }

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
    }
    
    let passwordLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .darkBrown
        $0.text = "비밀번호 *"
        if let text = $0.text, let lastCharacter = text.last {
            let attributedText = NSMutableAttributedString(string: text)
            let range = (text as NSString).range(of: String(lastCharacter))
            attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: range) // 원하는 색상으로 설정
            $0.attributedText = attributedText
        }

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
    }
    
    let passwordCheck = UITextField().then{
        
        let placeholderText = "다시한번 입력해 주세요"
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
    }
    
    let signUpBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("가입하기", for: .normal)
        $0.backgroundColor = .darkBrown
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .grayBeige
        
        hierarchy()
        layout()
    }
}

struct SignupVCPreView:PreviewProvider {
    static var previews: some View {
        SignupViewController().toPreview()
    }
}


