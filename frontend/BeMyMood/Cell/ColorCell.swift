//
//  colorCell.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/14.
//

import UIKit
import SnapKit
import Then

class ColorCell: UICollectionViewCell {
    
    static let cellIdentifier = "colorCell"
    
    var row: Int = 0 {
            didSet {
                updateCellAppearance()
            }
        }
        
        override var isSelected: Bool {
            didSet {
                updateCellAppearance()
            }
        }
    
    lazy var colorBtn = UIImageView().then{
        $0.image = UIImage(named: "color0")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(colorBtn)
        
        self.snp.makeConstraints{ make in
            make.width.height.equalTo(colorBtn)
        }
        self.contentView.snp.makeConstraints{ make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        colorBtn.snp.makeConstraints{ make in
            make.edges.equalTo(contentView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateCellAppearance() {
            if isSelected {
                colorBtn.image = UIImage(named: "selectedColor\(row)")
            } else {
                colorBtn.image = UIImage(named: "color\(row)")
            }
        }
}

