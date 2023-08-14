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
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "카페", spotTitle: "마카롱 카페", tags: ["힙한", "무채색"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "전시회", spotTitle: "모던 아트 전시회", tags: ["고즈넉한"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "밥집", spotTitle: "맛있는 밥집", tags: ["풍경위주의"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "놀이공원", spotTitle: "어드벤처 놀이공원", tags: ["LP가흐르는"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "카페", spotTitle: "우리집 근처 공원", tags: []),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "전시회", spotTitle: "아늑한 카페", tags: ["반려동물과 함께"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "밥집", spotTitle: "시원한 물놀이공원", tags: ["풍경위주의", "뮤트한", "친구와함께"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "놀이공원", spotTitle: "장소명8", tags: []),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: true, spotType: "카페", spotTitle: "장소명9", tags: ["키치한"]),
        SpotData(thumbnailImageUrl: "https://picsum.photos/200/300", isLiked: false, spotType: "전시회", spotTitle: "장소명10", tags: ["친구와함께"])
    ]

    //MARK: - UIComponents
    
    let filterSection = UIView().then{
        $0.backgroundColor = .white
    }
    
    let filterCategoryBtn = FilterOption(title: "카테고리")
    let filterRegionBtn = FilterOption(title: "지역")
    let filterIcon = UIImageView().then {
        $0.tintColor = .lightGray
        $0.image = UIImage(systemName: "slider.horizontal.3")
    }
    
    let spotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        layout()
        
        filterCategoryBtn.layer.cornerRadius = filterCategoryBtn.frame.height / 2
        filterCategoryBtn.addTarget(self, action: #selector(filterCategoryBtnTapped), for: .touchUpInside)

        filterRegionBtn.layer.cornerRadius = filterCategoryBtn.frame.height / 2
        filterRegionBtn.addTarget(self, action: #selector(filterRegionBtnTapped), for: .touchUpInside)
    }
    
    @objc func filterRegionBtnTapped(){
        let customBottomSheet = RegionBottomSheet()
        customBottomSheet.delegate = self
        self.presentPanModal(customBottomSheet)
    }
    
    @objc func filterCategoryBtnTapped(){
        let customBottomSheet = CategoryBottomSheet()
        customBottomSheet.delegate = self
        self.presentPanModal(customBottomSheet)
    }

}

extension FirstViewController {
    
    func hierarchy(){
        self.view.addSubview(filterSection)
        filterSection.addSubview(filterCategoryBtn)
        filterSection.addSubview(filterRegionBtn)
        filterSection.addSubview(filterIcon)
        self.view.addSubview(spotCollectionView)
        
        spotCollectionView.dataSource = self
        spotCollectionView.delegate = self
        spotCollectionView.register(SpotCell.self, forCellWithReuseIdentifier: "spotCell")
    }
    
    func layout(){
        filterSection.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalTo(spotCollectionView.snp.top)
        }
        
        filterIcon.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        filterRegionBtn.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(filterIcon.snp.leading).offset(-5)
//            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        filterCategoryBtn.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(filterRegionBtn.snp.leading).offset(-5)
//            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        
        spotCollectionView.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - Collection View
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tempData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let spotCell = spotCollectionView.dequeueReusableCell(withReuseIdentifier: "spotCell", for: indexPath) as! SpotCell
        let cellData = tempData[indexPath.row]
        
        spotCell.thumbnailImage.loadImage(from: cellData.thumbnailImageUrl)
        if cellData.isLiked{
            spotCell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            spotCell.heartButton.isSelected = true
        }else{
            spotCell.heartButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
            spotCell.heartButton.isSelected = false
        }
        spotCell.spotTypeLabel.text = cellData.spotType
        spotCell.spotTitleLabel.text = cellData.spotTitle
        
        spotCell.heartButton.addTarget(self, action: #selector(heartBtnTap(_:)), for: .touchUpInside)

        spotCell.tags = cellData.tags
        
        return spotCell
    }
    
    @objc func heartBtnTap(_ sender: UIButton){
        print("heart Button Tap")
        if sender.isSelected{
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.isSelected = false
        }else{
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.isSelected = true
        }
        /// TODO Heart Tap API
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

extension FirstViewController: FilterCategoryDataDelegate, FilterRegionDataDelegate {
    
    func setCategoryFilterTitle(_ title: String) {
        filterCategoryBtn.isSelected = true
        filterCategoryBtn.setTitle(title, for: .selected)
        filterCategoryBtn.tintColor = .orange
        filterCategoryBtn.layer.borderColor = UIColor.orange.cgColor
        updateFilterIconColor()
        /// 검색 with filter option API 호출
    }
    
    func setRegionFilterTitle(_ title: String) {
        filterRegionBtn.isSelected = true
        filterRegionBtn.setTitle(title, for: .selected)
        filterRegionBtn.tintColor = .orange
        filterRegionBtn.layer.borderColor = UIColor.orange.cgColor
        updateFilterIconColor()
        /// 검색 with filter option API 호출
    }
    
    func updateFilterIconColor(){
        if filterCategoryBtn.isSelected || filterRegionBtn.isSelected {
            filterIcon.tintColor = .orange
        }
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
    let tags: [String]
}
