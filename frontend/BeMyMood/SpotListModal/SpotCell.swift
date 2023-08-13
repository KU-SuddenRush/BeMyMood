//
//  SpotCell.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/12.
//

import UIKit
import SwiftUI

class SpotCell: UICollectionViewCell {
    
    var tags: [String]?
//    lazy var tagCollectionViewWidth = CGRect(origin: spotTagCollectionView.contentOffset, size: spotTagCollectionView.bounds.size).width
    
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

    let spotTagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let tagCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return tagCV
    }()
    
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
        
        spotTagCollectionView.dataSource = self
        spotTagCollectionView.delegate = self
        spotTagCollectionView.register(SpotTagCell.self, forCellWithReuseIdentifier: "spotTagCell")
    }
    
}

extension SpotCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags?.count ?? 0
    }
    
//    func calculateItemCount(_ itemCount: Int) -> Int{
//
//        return
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let spotTagCell = spotTagCollectionView.dequeueReusableCell(withReuseIdentifier: "spotTagCell", for: indexPath) as! SpotTagCell
        
        spotTagCell.tagLabel.text = "#" + tags![indexPath.row]
        
        return spotTagCell
    }
    
    func calculateTagCellWidth(for tagText: String) -> CGFloat {
        // 셀 폭을 계산하는 로직을 작성합니다. 텍스트의 길이에 따라 동적으로 폭을 설정하거나, 고정된 값으로 설정할 수 있습니다.
        let textWidth = tagText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width
        let cellWidth = textWidth + 40.0 // 예시로 폭에 텍스트 너비를 추가하고 여백을 더합니다.
        
        return cellWidth
    }
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = calculateTagCellWidth(for: tags![indexPath.row])
        
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let totalSpacing: CGFloat = (numberOfItemsPerRow - 1) * 10 // 가로 간격의 합
//        
//        let cellWidth = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
//        let cellHeight: CGFloat = 100 // 예시로 고정된 높이
//        
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10 // 가로 간격 설정
//    }
}

struct SpotCellPreView:PreviewProvider {
    static var previews: some View {
        SpotCell().toPreview()
    }
}
