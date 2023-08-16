//
//  MoodBoardCell.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/17.
//

import UIKit
import SnapKit
import Then

class MoodBoardCell: UICollectionViewCell {
    
    static let cellIdentifier = "stickerCell"
    
    
    var moodBoard = UIImageView().then{
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentView.addSubview(moodBoard)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(moodBoard)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        moodBoard.snp.makeConstraints{ make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
