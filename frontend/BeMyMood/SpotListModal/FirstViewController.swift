//
//  FirstViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import UIKit
import SwiftUI

class FirstViewController: UIViewController {
    
    var spotDetailNavigationController: UINavigationController!
//    weak var delegate: SpotCellTapDelegate?
    
    var spotData: [SpotData] = []

    //MARK: - UIComponents
    
    let filterSection = UIView().then{
        $0.backgroundColor = .white
    }
    
    let filterCategoryBtn: FilterOption = {
        let FCBtn = FilterOption(title: "카테고리")
        FCBtn.layer.cornerRadius = FCBtn.frame.height / 2 + 3
        return FCBtn
    }()

    let filterRegionBtn: FilterOption = {
        let FRBtn = FilterOption(title: "지역")
        FRBtn.layer.cornerRadius = FRBtn.frame.height / 2 + 3
        return FRBtn
    }()
    
    let filterIcon = UIButton().then {
        $0.setImage(UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setImage(UIImage(named: "filter.fill")?.withRenderingMode(.alwaysOriginal), for: .selected)
    }
    
    let spotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        layout()
        
        dataInit()
        
        filterCategoryBtn.addTarget(self, action: #selector(filterCategoryBtnTapped), for: .touchUpInside)

        filterRegionBtn.addTarget(self, action: #selector(filterRegionBtnTapped), for: .touchUpInside)
    }
    
    func dataInit(){
        ApiClient.getSpotInfos { result in
            switch result {
            case .success(let getReviewDetailDTO):
                print(getReviewDetailDTO)
                for spotInfo in getReviewDetailDTO.spotInfos{
                    let spotId = spotInfo.spotId
                    let thumbnailImageUrl = spotInfo.spotThumbnailImageUrl
                    let isLiked = spotInfo.bookmarked
                    let spotType = spotInfo.categoryName
                    let spotTitle = spotInfo.spotName
                    let tags = spotInfo.moodNames
                    
                    self.spotData.append(SpotData(spotId: spotId, thumbnailImageUrl: thumbnailImageUrl, isLiked: isLiked, spotType: spotType, spotTitle: spotTitle, tags: tags))
                    
                    self.spotCollectionView.reloadData()
                }
            case .failure(_):
                print("getSpotInfos failed")
            }
        }
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

@objc // for override func in SecondVC
extension FirstViewController {
    
    func hierarchy(){
        print("self.view")
        print(self.view)
        self.view.addSubview(filterSection)
        print("filterSection.superview")
        print(filterSection.superview)

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
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
//            make.bottom.equalTo(spotCollectionView.snp.top)
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
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(filterSection.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - Collection View
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        spotData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let spotCell = spotCollectionView.dequeueReusableCell(withReuseIdentifier: "spotCell", for: indexPath) as! SpotCell
        let cellData = spotData[indexPath.row]
        
        spotCell.thumbnailImage.loadImage(from: cellData.thumbnailImageUrl)
        if cellData.isLiked{
            spotCell.heartButton.isSelected = true
        }else{
            spotCell.heartButton.isSelected = false
        }
        spotCell.spotTypeLabel.text = cellData.spotType
        spotCell.spotTitleLabel.text = cellData.spotTitle
        
        spotCell.heartButton.addTarget(self, action: #selector(heartBtnTap(_:)), for: .touchUpInside)

        spotCell.tags = cellData.tags
        spotCell.spotTagCollectionView.reloadData()
        
        return spotCell
    }
    
    @objc func heartBtnTap(_ sender: UIButton){
        print("heart Button Tap")
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
        /// TODO Heart Tap API
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("didSelectItemAt \(indexPath)")
//        delegate?.moveToSpotDetail(spotId: spotData[indexPath.row].spotId)
        
        /// TODO get Detail Info API
        spotDetailNavigationController?.pushViewController(SpotDetailViewController(), animated: true)
    }
    
}

extension FirstViewController: UICollectionViewDelegateFlowLayout {
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = spotCollectionView.frame.width / 2 - 10.0
        let height: CGFloat = width + 45
        return CGSize(width: width, height: height)
    }
    
    // CollectionView Cell의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

@objc // for override func in SecondVC
extension FirstViewController: FilterCategoryDataDelegate, FilterRegionDataDelegate {
    
    func setCategoryFilterTitle(_ title: String) {
        filterCategoryBtn.isSelected = true
        filterCategoryBtn.setTitle(title, for: .selected)
        filterCategoryBtn.layer.borderColor = UIColor.orange.cgColor
        updateFilterIconColor()
        /// 검색 with filter option API 호출
    }
    
    func setRegionFilterTitle(_ title: String) {
        filterRegionBtn.isSelected = true
        filterRegionBtn.setTitle(title, for: .selected)
        filterRegionBtn.layer.borderColor = UIColor.orange.cgColor
        updateFilterIconColor()
        /// 검색 with filter option API 호출
    }
    
    func updateFilterIconColor(){
        if filterCategoryBtn.isSelected || filterRegionBtn.isSelected {
            filterIcon.isSelected = true
        }else{
            filterIcon.isSelected = false
        }
    }
    
}


struct FirstVCPreView:PreviewProvider {
    static var previews: some View {
        FirstViewController().toPreview()
    }
}

struct SpotData{
    let spotId: Int
    let thumbnailImageUrl: String
    let isLiked: Bool
    let spotType: String
    let spotTitle: String
    let tags: [String]
}
