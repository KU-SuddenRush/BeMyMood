//
//  RecordPictureCell.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/13.
//

import UIKit

class RecordPictureCell: UICollectionViewCell {
    
    static let cellIdentifier = "reviewPictureCell"
    
    
    var recordImage = UIImageView().then{
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    let removeBtn = UIButton().then{
        $0.setImage(UIImage(named: "deletePicture"), for: .normal)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(recordImage)
        self.contentView.addSubview(removeBtn)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(recordImage)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        recordImage.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        removeBtn.snp.makeConstraints{ make in
            make.top.equalTo(recordImage.snp.top).offset(4)
            make.trailing.equalTo(recordImage.snp.trailing).offset(-4)
            make.width.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
