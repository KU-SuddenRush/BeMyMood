//
//  AllMoodViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit

class RecentMoodBoardViewController: UIViewController {
    
    var recentMBnavigationController: UINavigationController!
    
    //MARK: - UIComponents
    
    let empty = UIImageView().then{
        $0.image = UIImage(named: "emptyBoard")
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFill
    }
    
    let makeBtn = UIButton().then{
        $0.setTitle("+ 무드보드 만들기", for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = .darkBrown
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.textAlignment = .center
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        self.makeBtn.addTarget(self, action: #selector(makeBtnDidTab), for: .touchUpInside)
    }
    
    @objc func makeBtnDidTab() {
        let moodBoardEditVC = MoodBoardEditViewController()
        self.recentMBnavigationController?.pushViewController(moodBoardEditVC, animated: true)
    }
    
    
}

extension RecentMoodBoardViewController {
    
    func hierarchy(){
        self.view.addSubview(empty)
        self.view.addSubview(makeBtn)
    }
    
    func layout(){
        empty.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.centerX.equalToSuperview()
            make.width.equalTo(304)
            make.height.equalTo(371)
        }
        
        makeBtn.snp.makeConstraints{ make in
            make.top.equalTo(empty.snp.bottom).offset(34)
            make.centerX.equalToSuperview()
            make.width.equalTo(216)
            make.height.equalTo(56)
        }
    }
}
