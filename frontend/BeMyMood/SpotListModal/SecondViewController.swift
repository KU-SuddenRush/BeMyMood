//
//  SecondViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import UIKit

class SecondViewController: FirstViewController {
    
    let filterMoodBtn: FilterOption = {
        let FMBtn = FilterOption(title: "무드")
        FMBtn.layer.cornerRadius = FMBtn.frame.height / 2 + 3
        return FMBtn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hierarchy()
        layout()

        filterMoodBtn.addTarget(self, action: #selector(filterMoodBtnTapped), for: .touchUpInside)
    }
    
    @objc func filterMoodBtnTapped(){
        let customBottomSheet = MoodBottomSheet()
        customBottomSheet.delegate = self
        self.presentPanModal(customBottomSheet)
    }
}

extension SecondViewController {
    
    override func hierarchy(){
        super.hierarchy()
        filterSection.addSubview(filterMoodBtn)
    }
    
    override func layout(){
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
        
        filterMoodBtn.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(filterIcon.snp.leading).offset(-5)
//            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        filterRegionBtn.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(filterMoodBtn.snp.leading).offset(-5)
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

extension SecondViewController: FilterMoodDataDelegate {
    
    func setMoodFilterTitle(_ title: String) {
        filterMoodBtn.isSelected = true
        filterMoodBtn.setTitle(title, for: .selected)
        filterMoodBtn.layer.borderColor = UIColor.orange.cgColor
        updateFilterIconColor()
        /// 검색 with filter option API 호출
        updateSpotCollectionView()
    }
    
    override func updateFilterIconColor(){
        if filterCategoryBtn.isSelected || filterRegionBtn.isSelected || filterMoodBtn.isSelected{
            filterIcon.isSelected = true
        }else{
            filterIcon.isSelected = false
        }
    }
    
    override func updateSpotCollectionView(){
        var category: String?
        var location: String?
        var mood: String?
        
        category = filterCategoryBtn.titleLabel?.text
        if category == "카테고리" {
            category = nil
        }
        location = filterRegionBtn.titleLabel?.text
        if location == "지역" {
            location = nil
        }
        mood = filterMoodBtn.titleLabel?.text
        if mood == "무드" {
            mood = nil
        }
        print("category is \(category)")
        print("location is \(location)")
        print("mood is \(mood)")
        
        ApiClient.getSpotInfosWithFilter(category: category, location: location, mood: mood){ result in
            switch result {
            case .success(let getSpotDataDTO):
                print(getSpotDataDTO)
                self.spotData.removeAll()
                for spotInfo in getSpotDataDTO.spotInfos{
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
                print("getSpotInfosWithFilter failed")
            }
        }
    }
}
