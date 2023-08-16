//
//  PopularViewcontroller.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/17.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class PopularViewcontroller: UIViewController {
    
    var recentMBnavigationController: UINavigationController!
    
    //MARK: - UIComponents
    
    let empty = UIImageView().then{
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "lastMoodBoard")
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFill
    }
    
    let popular = UILabel().then{
        $0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .black
        
        $0.text = "이번주 가장 인기 있어요"
    }
    
    let first = UIImageView().then{
        $0.image = UIImage(named: "first")
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
    }
    
    
}

extension PopularViewcontroller {
    
    func hierarchy(){
        self.view.addSubview(popular)
        self.view.addSubview(empty)
        self.view.addSubview(first)
    }
    
    func layout(){
        empty.snp.makeConstraints{ make in
            make.top.equalTo(popular.snp.bottom).offset(22)
            make.centerX.equalToSuperview()
            make.width.equalTo(304)
            make.height.equalTo(371)
        }
        
        popular.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(30.27)
            make.leading.equalToSuperview().offset(24.3)
        }
        
        first.snp.makeConstraints{ make in
            make.top.equalTo(empty.snp.bottom).offset(27.12)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(8)
        }
    }
}
