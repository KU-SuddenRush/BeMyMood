//
//  StickerCell.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/15.
//

import UIKit
import SnapKit
import Then

class StickerCell: UICollectionViewCell {
    
    static let cellIdentifier = "stickerCell"
    
    
    var sticker = UIImageView().then{
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(sticker)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(sticker)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        sticker.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
