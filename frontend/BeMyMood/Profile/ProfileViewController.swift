//
//  ProfileViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit
import Then
import SnapKit

class ProfileViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let mypage = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "마이페이지"
    }
    
    let profile = UIImageView().then{
        $0.image = UIImage(named:"profileImage")
    }
    
    let name = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "김건국"
    }
    
    let myMood = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = "내 무드 8"
    }
    
    let moodBtn = UIButton().then{
        $0.layer.cornerRadius = 25/2
        $0.layer.masksToBounds = true
        $0.setTitle("무드 재설정", for: .normal)
        $0.backgroundColor = .grayBeige
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    let line1 = UIView().then{
        $0.backgroundColor = UIColor(hex:"#F1F1F1")
    }
    
    let detailBtn = UIButton().then{
        $0.setTitle("자세히 보기", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.darkBrown_80, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    let myBadge = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = "획득한 뱃지 4"
    }
    
    let line2 = UIView().then{
        $0.backgroundColor = UIColor(hex:"#F1F1F1")
    }
    
    let badge1 = UIImageView().then{
        $0.image = UIImage(named:"badge1")
    }
    
    let badge2 = UIImageView().then{
        $0.image = UIImage(named:"badge2")
    }
    
    let badge3 = UIImageView().then{
        $0.image = UIImage(named:"badge3")
    }
    
    let line3 = UIView().then{
        $0.backgroundColor = UIColor(hex:"#F1F1F1")
    }
    
    
    let myRecord = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = "작성한 기록"
    }
    let mySpot = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = "관심 스팟"
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
    }


}
