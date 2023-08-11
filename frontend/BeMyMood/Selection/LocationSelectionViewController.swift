//
//  LocationSelectionViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/09.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class LocationSelectionViewController: UIViewController {
    
    //MARK: - UIComponents
   
    let progressBar = UIProgressView().then{
        $0.progressViewStyle = .default
        $0.progressTintColor = .darkBrown_50
        $0.trackTintColor = .darkBrown_30
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4/2
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 4/2
        $0.subviews[1].clipsToBounds = true
        $0.progress = 1
    }
    
    let label = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "선호하는 지역을 알려주세요"
    }
    
    let searchBar1 = UITextField().then{
        $0.placeholder = "동 이름으로 찾기"
        $0.attributedPlaceholder = NSAttributedString(string: "동 이름으로 찾기", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkBrown])
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: $0.frame.size.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    
    let searchBar2 = UITextField().then{
        $0.placeholder = "동 이름으로 찾기"
        $0.attributedPlaceholder = NSAttributedString(string: "동 이름으로 찾기", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkBrown])
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: $0.frame.size.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    
    let searchBar3 = UITextField().then{
        $0.placeholder = "동 이름으로 찾기"
        $0.attributedPlaceholder = NSAttributedString(string: "동 이름으로 찾기", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkBrown])
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: $0.frame.size.height))
        $0.leftView = paddingView
        $0.leftViewMode = .always
    }
    
    let locationSearchBtn = UIButton().then{
        $0.setTitle("현재 위치로 찾기", for: .normal)
        $0.backgroundColor = .grayBeige
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
        
        let iconImage = UIImage(named: "location") // 원하는 아이콘 이미지로 변경
            $0.setImage(iconImage, for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 아이콘 위치 조정
    }
    
    let nextBtn = UIButton().then{
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .darkBrown_30
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()

    }
    
    
    //MARK: - Btn


}

struct LocationSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        LocationSelectionViewController().toPreview()
    }
}

