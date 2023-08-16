//
//  SpotTagCell.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/13.
//

import UIKit

class SpotTagCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    
    let tagLabel = UILabel().then{
        $0.textAlignment = .center
        $0.text = "#tag_default"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor(red: 0.35, green: 0.33, blue: 0.32, alpha: 1)
        $0.backgroundColor = UIColor(red: 0.92, green: 0.91, blue: 0.9, alpha: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        commonInit()
    }
    
    private func commonInit() {

        self.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        self.tagLabel.layer.cornerRadius = self.frame.size.height / 2
        self.tagLabel.clipsToBounds = true
    }
    
}
