//
//  colorCell.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/14.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    static let cellIdentifier = "reviewPictureCell"
    
    
    var colorBtn = UIButton().then{
        $0.setImage(UIImage(named: "color0"), for: .normal)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(colorBtn)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(colorBtn)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        colorBtn.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

