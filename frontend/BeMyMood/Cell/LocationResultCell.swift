//
//  LocationResultCell.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/13.
//

import UIKit
import SnapKit
import Then

class LocationResultCell: UICollectionViewCell {
    
    static let cellIdentifier = "locationResultCell"
    
    
    var locationLabel = cellPaddingLabel().then{
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.layer.masksToBounds = true
    }
    
   
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(locationLabel)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(locationLabel)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
