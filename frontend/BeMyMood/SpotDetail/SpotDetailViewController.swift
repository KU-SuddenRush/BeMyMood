//
//  SpotDetailViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/14.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class SpotDetailViewController: UIViewController {
    
    var tempData = SpotDetailInfos(spotId: 3, bookmarked: true, spotName: "누데이크 성수점", spotThumbnailImageUrl: ["https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300"], categoryName: "카페", moodNames: ["힙한","소품이많은","무채색","어두운","특이한소재","포인트컬러","정적인","키치한","세련된","단조로운"], address: "서울 성동구 성수이로7길 26 1층", url: "http://www.nudake.com", description: "대법관의 임기는 6년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다. 대통령이 궐위된 때 또는 대통령 당선자가 사망하거나 판결 기타의 사유로 그 자격을 상실한 때에는 60일 이내에 후임자를 선거한다. 국정감사 및 조사에 관한 절차 기타 필요한 사항은 법률로 정한다. 국방상 또는 국민경제상 긴절한 필요로 인하여 법률이 정하는 경우를 제외하고는, 사영기업을 국유 또는 공유로 이전하거나 그 경영을 통제 또는 관리할 수 없다.", recommends: ["음료", "전시", "디저트"], menuImageUrls: ["https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300", "https://picsum.photos/200/300"])
    
    //MARK: - UIComponents
    let categoryLabel = UILabel().then{
        $0.backgroundColor = .white
        $0.text = "Category Label"
        $0.textColor = .orange
    }
    
    let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let tagCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagCV.backgroundColor = .white
        tagCV.showsHorizontalScrollIndicator = false
        return tagCV
    }()
    
    let slidingTabVC = UISlidingTabController().then{
        $0.setHeaderActiveColor(color: .orange)
        $0.setHeaderInActiveColor(color: .black)
        $0.setHeaderBackgroundColor(color: .white)
    }
    
    let addModeBoardView = UIView().then{
        $0.backgroundColor = .purple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        dataInit()
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.register(SpotTagCell.self, forCellWithReuseIdentifier: "spotTagCell")
    }
    
    func dataInit(){
        categoryLabel.text = tempData.categoryName
        
        slidingTabVC.addItem(item: DetailViewController().then{ $0.tempData = self.tempData }, title: "상세정보")
        slidingTabVC.addItem(item: UIViewController(), title: "리뷰")
        slidingTabVC.build()
    }
    
}

extension SpotDetailViewController{
    
    func hierarchy(){
        self.view.addSubview(categoryLabel)
        self.view.addSubview(tagCollectionView)
        self.view.addSubview(slidingTabVC.view)
        self.view.addSubview(addModeBoardView)
    }
    
    func layout(){
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(20)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.height.equalTo(24)
        }
        
        tagCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(60)
        }
        
        slidingTabVC.view.snp.makeConstraints{ make in
            make.top.equalTo(tagCollectionView.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addModeBoardView.snp.top)
        }
        
        addModeBoardView.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(104)
        }
    }
}

//MARK: - Spot Tag Collection View
extension SpotDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempData.moodNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let spotTagCell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "spotTagCell", for: indexPath) as! SpotTagCell
        
        spotTagCell.tagLabel.text = "#" + tempData.moodNames[indexPath.row]
        
        return spotTagCell
    }
    
    func calculateTagCellWidth(for tagText: String) -> CGFloat {
        // 셀 폭을 계산하는 로직을 작성합니다. 텍스트의 길이에 따라 동적으로 폭을 설정하거나, 고정된 값으로 설정할 수 있습니다.
        let textWidth = tagText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)]).width
        let cellWidth = textWidth + 35.0 // 예시로 폭에 텍스트 너비를 추가하고 여백을 더합니다.
        
        return cellWidth
    }
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = calculateTagCellWidth(for: tempData.moodNames[indexPath.row])
        
        return CGSize(width: cellWidth, height: collectionView.frame.height / 2 - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // 가로 간격 설정
    }
}

struct SpotDetailVCPreView:PreviewProvider {
    static var previews: some View {
        SpotDetailViewController().toPreview()
    }
}

struct SpotDetailInfos{
    let spotId: Int
    let bookmarked: Bool
    let spotName: String
    let spotThumbnailImageUrl: [String]
    let categoryName: String
    let moodNames: [String]
    let address: String
    let url: String
    let description: String
    let recommends: [String]
    let menuImageUrls: [String]
}
