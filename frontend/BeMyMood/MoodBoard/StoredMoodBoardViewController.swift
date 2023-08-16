//
//  StoredMoodBoardViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit

class StoredMoodBoardViewController: UIViewController {
    
    var storedMBnavigationController: UINavigationController!
    
    //MARK: - UIComponents
    
    let count = UILabel().then{
        $0.text = "5개의 무드보드"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        
    }
    
    let selectBtn = UIButton().then{
        $0.setTitle("선택", for: .normal)
        $0.layer.cornerRadius = 25/2
        $0.backgroundColor = .grayBeige
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.titleLabel?.textAlignment = .center
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.cellIdentifier)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
//
//        self.makeBtn.addTarget(self, action: #selector(makeBtnDidTab), for: .touchUpInside)
    }
    
//    @objc func makeBtnDidTab() {
//        let moodBoardEditVC = MoodBoardEditViewController()
//        self.recentMBnavigationController?.pushViewController(moodBoardEditVC, animated: true)
//    }
    
    
}

extension StoredMoodBoardViewController {
    
    func hierarchy(){
        self.view.addSubview(count)
        self.view.addSubview(selectBtn)
        
        self.view.addSubview(collectionView)
    }
    
    func layout(){
        count.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        selectBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(53)
            make.height.equalTo(25)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(count.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(15.5)
            make.trailing.equalToSuperview().offset(-15.5)
            make.bottom.equalToSuperview()
        }
    }
}
