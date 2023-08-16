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
    }
    
    override func updateFilterIconColor(){
        if filterCategoryBtn.isSelected || filterRegionBtn.isSelected || filterMoodBtn.isSelected{
            filterIcon.isSelected = true
        }else{
            filterIcon.isSelected = false
        }
    }
}
