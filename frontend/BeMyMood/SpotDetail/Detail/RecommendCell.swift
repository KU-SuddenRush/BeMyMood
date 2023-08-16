//
//  RecommendCell.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    
    lazy var recommmendImage = UIImageView()
    
    lazy var recommendLabel = UILabel().then{
        $0.textColor = UIColor(red: 0.349, green: 0.325, blue: 0.322, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.947, green: 0.947, blue: 0.947, alpha: 1)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        self.addSubview(recommmendImage)
        self.addSubview(recommendLabel)
        
        recommendLabel.snp.makeConstraints{ make in
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.trailing.equalTo(-24)
            make.height.equalTo(24)
        }
        
        recommmendImage.snp.makeConstraints{ make in
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.trailing.equalTo(recommendLabel.snp.leading).offset(-10)
            make.size.equalTo(24)
            make.leading.equalTo(24)
        }

        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
}
    
//class cellPaddingLabel: UILabel {
//    var padding = UIEdgeInsets(top: 5, left: 10, bottom: 4, right:10)
//
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: rect.inset(by: padding))
//    }
//
//    override var intrinsicContentSize: CGSize {
//            var contentSize = super.intrinsicContentSize
//            contentSize.height += padding.top + padding.bottom
//            contentSize.width += padding.left + padding.right
//
//            return contentSize
//        }
//}
