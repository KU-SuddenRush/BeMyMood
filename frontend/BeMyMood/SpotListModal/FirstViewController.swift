//
//  FirstViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import UIKit
import SwiftUI

class FirstViewController: UIViewController {
    
    var tempData: [SpotData] = [
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "카페", spotTitle: "마카롱 카페"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "전시회", spotTitle: "모던 아트 전시회"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "밥집", spotTitle: "맛있는 밥집"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "놀이공원", spotTitle: "어드벤처 놀이공원"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "카페", spotTitle: "우리집 근처 공원"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "전시회", spotTitle: "아늑한 카페"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "밥집", spotTitle: "시원한 물놀이공원"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "놀이공원", spotTitle: "장소명8"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "카페", spotTitle: "장소명9"),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "전시회", spotTitle: "장소명10")
    ]

    //MARK: - UIComponents
    
    let filterSection = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    let spotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        layout()
    }

}

extension FirstViewController {
    
    func hierarchy(){
        self.view.addSubview(filterSection)
        self.view.addSubview(spotCollectionView)
        spotCollectionView.dataSource = self
        spotCollectionView.delegate = self
        spotCollectionView.register(SpotCell.self, forCellWithReuseIdentifier: "spotCell")
    }
    
    func layout(){
        filterSection.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50).priority(.high)
            make.bottom.equalTo(spotCollectionView.snp.top)
        }
        
        spotCollectionView.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tempData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let spotCell = spotCollectionView.dequeueReusableCell(withReuseIdentifier: "spotCell", for: indexPath) as! SpotCell
        let cellData = tempData[indexPath.row]
        
        spotCell.thumbnailImage.loadImage(from: cellData.thumbnailImageUrl)
        if cellData.isLiked{
            spotCell.heartButton.image = UIImage(systemName: "heart.fill")
            spotCell.isSelected = true
        }else{
            spotCell.heartButton.image = UIImage(systemName: "heart")
            spotCell.isSelected = false
        }
        spotCell.spotTypeLabel.text = cellData.spotType
        spotCell.spotTitleLabel.text = cellData.spotTitle
        
        return spotCell
    }
    
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = spotCollectionView.frame.width / 2 - 10.0
        let height: CGFloat = width + 35
        return CGSize(width: width, height: height)
    }
}


struct FirstVCPreView:PreviewProvider {
    static var previews: some View {
        FirstViewController().toPreview()
    }
}

struct SpotData{
    let thumbnailImageUrl: String
    let isLiked: Bool
    let spotType: String
    let spotTitle: String
}
