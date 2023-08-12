//
//  SpotCell.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/12.
//

import UIKit
import SwiftUI

class SpotCell: UICollectionViewCell {
    
    //MARK: - UIComponents
    let thumbnailImage = UIImageView().then {
        $0.image = UIImage(named: "apple.logo")
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    let heartButton = UIImageView().then {
        $0.tintColor = .black
        $0.image = UIImage(systemName: "heart")
        /// TODO
        /// 하트버튼 클릭시 API 호출 addTarget
    }
    
    let spotTitleLabel = UILabel().then{
        $0.font = UIFont(name: "AppleSDGothicNeoB00-Regular", size: 18)
        $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    let spotTypeLabel = UILabel().then{
        $0.font = UIFont(name: "AppleSDGothicNeoR00-Regular", size: 14)
        $0.textColor = UIColor(red: 1, green: 0.54, blue: 0, alpha: 1)
    }
    
    let spotTagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .red
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
        
        self.addSubview(thumbnailImage)
        thumbnailImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(thumbnailImage.snp.width) // 1:1
        }
        
        thumbnailImage.addSubview(heartButton)
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImage).offset(12)
            make.trailing.equalTo(thumbnailImage).offset(-12)
            make.size.equalTo(24)
        }
        
        thumbnailImage.addSubview(spotTitleLabel)
        spotTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImage.snp.leading).offset(10)
            make.trailing.equalTo(thumbnailImage.snp.trailing).offset(-10)
            make.bottom.equalTo(thumbnailImage).offset(-16)
            make.height.equalTo(27)
        }
        
        thumbnailImage.addSubview(spotTypeLabel)
        spotTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImage.snp.leading).offset(10)
            make.trailing.equalTo(thumbnailImage.snp.trailing).offset(-10)
            make.bottom.equalTo(spotTitleLabel.snp.top)
            make.height.equalTo(21)
        }
        
        self.addSubview(spotTagCollectionView)
        spotTagCollectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(thumbnailImage.snp.bottom)
        }
        
    }
    
}

struct SpotCellPreView:PreviewProvider {
    static var previews: some View {
        SpotCell().toPreview()
    }
}
