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
        $0.image = UIImage(named:"profile")
    }
    
    let name = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "김건국"
    }
    
    let nextButton = UIButton().then{
        $0.setTitle("프로필", for: .normal)
        $0.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
    }
    
    let myMood = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "내 무드 8"
    }
    
    let detailBtn = UIButton().then{
        $0.setTitle("자세히 보기", for: .normal)
        $0.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
    }
    let myBadge = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "획득한 뱃지 4"
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.showsHorizontalScrollIndicator = false
        $0.allowsSelection = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(RecordPictureCell.self, forCellWithReuseIdentifier: RecordPictureCell.cellIdentifier)
    }
    
    let myRecord = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "작성한 기록"
    }
    
    let mySpot = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
