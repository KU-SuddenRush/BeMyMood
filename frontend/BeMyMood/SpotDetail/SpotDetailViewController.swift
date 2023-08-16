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
    
    var tempData = SpotDetailInfos(spotId: 3, bookmarked: true, spotName: "누데이크 성수점", spotThumbnailImageUrl: ["https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300"], categoryName: "카페", moodNames: ["힙한","소품이많은","무채색","어두운","특이한소재","포인트컬러","정적인","키치한","세련된","단조로운"], address: "서울 성동구 성수이로7길 26 1층", url: "http://www.nudake.com", time: "매일 11:00 - 21:00, 라스트오더 20:45", description: "대법관의 임기는 6년으로 하며, 법률이 정하는 바에 의하여 연임할 수 있다. 대통령이 궐위된 때 또는 대통령 당선자가 사망하거나 판결 기타의 사유로 그 자격을 상실한 때에는 60일 이내에 후임자를 선거한다. 국정감사 및 조사에 관한 절차 기타 필요한 사항은 법률로 정한다. 국방상 또는 국민경제상 긴절한 필요로 인하여 법률이 정하는 경우를 제외하고는, 사영기업을 국유 또는 공유로 이전하거나 그 경영을 통제 또는 관리할 수 없다.", recommends: ["음료", "전시", "디저트"], menuImageUrls: ["https://picsum.photos/200/300","https://picsum.photos/200/300","https://picsum.photos/200/300", "https://picsum.photos/200/300"])
    
    //MARK: - UIComponents
    
    let navigationView = UIView()
    
    let navigationBackBtn = UIButton().then{
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let navigationTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "장소명_default"
    }
    
    let spotIsLikedButton = UIButton().then{
        $0.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setImage(UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .selected)
    }
    
    let headerView = UIView().then{
        $0.backgroundColor = .white
    }
    
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
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 0.947, green: 0.947, blue: 0.947, alpha: 1).cgColor
        $0.backgroundColor = .white
    }
    
    let addMoodBoardDescription = UILabel().then{
        $0.text = "이 곳에 다녀왔나요?"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .lightGray
        $0.textAlignment = .center
    }
    
    let addMoodBoardBtn = UIButton().then{
        $0.setTitle("내 무드보드에 추가", for: .normal)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor(red: 0.349, green: 0.325, blue: 0.322, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        slidingTabVC.delegate = self
        
        hierarchy()
        layout()
        
        dataInit()
        
        navigationBackBtn.addTarget(self, action: #selector(backBtnDidTab), for: .touchUpInside)
        spotIsLikedButton.addTarget(self, action: #selector(likeBtnDidTap), for: .touchUpInside)
        
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.register(SpotTagCell.self, forCellWithReuseIdentifier: "spotTagCell")
        
        addMoodBoardBtn.addTarget(self, action: #selector(addMoodBoardBtnTapped), for: .touchUpInside)
    }
    
    func dataInit(){
        categoryLabel.text = tempData.categoryName
        
        let firstVC = DetailViewController().then{
            $0.tempData = tempData
        }
        slidingTabVC.addItem(item: firstVC, title: "상세정보")
        slidingTabVC.addItem(item: ReviewViewController(), title: "리뷰")
        slidingTabVC.build()
    }
    
    @objc func backBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func likeBtnDidTap() {
        spotIsLikedButton.isSelected = !spotIsLikedButton.isSelected
        
        print("Spot Like Btn Tap !")
        /// TODO Like Btn API
    }
    
    @objc func addMoodBoardBtnTapped(){
        print("addMoodBoardBtnTapped")
        
        /// TODO : MoveTo addMoodBoard View
    }
    
}

extension SpotDetailViewController{
    
    func hierarchy(){
        self.view.addSubview(navigationView)
        navigationView.addSubview(navigationBackBtn)
        navigationView.addSubview(navigationTitle)
        navigationView.addSubview(spotIsLikedButton)
        
        self.view.addSubview(headerView)
        headerView.addSubview(categoryLabel)
        headerView.addSubview(tagCollectionView)
        self.view.addSubview(slidingTabVC.view)
        self.view.addSubview(addModeBoardView)
        addModeBoardView.addSubview(addMoodBoardDescription)
        addModeBoardView.addSubview(addMoodBoardBtn)
    }
    
    func layout(){
        
        updateHeaderViewContraintToVisible()
        
        navigationView.snp.makeConstraints{ make in
            make.top.equalTo(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        navigationBackBtn.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.size.equalTo(24)
        }
        
        navigationTitle.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(navigationBackBtn.snp.trailing).offset(10)
            make.height.equalTo(30)
        }
        
        spotIsLikedButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.size.equalTo(24)
        }

        slidingTabVC.view.snp.makeConstraints{ make in
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addModeBoardView.snp.top)
        }
        
        addModeBoardView.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        addMoodBoardDescription.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        
        addMoodBoardBtn.snp.makeConstraints{ make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(addModeBoardView.snp.bottom).offset(-25)
            make.top.equalTo(addMoodBoardDescription.snp.bottom).offset(3)
            make.height.equalTo(56)
        }
    }
    
    func updateHeaderViewContraintToVisible(){
        
        headerView.removeConstraints(headerView.constraints)
        categoryLabel.removeConstraints(categoryLabel.constraints)
        tagCollectionView.removeConstraints(tagCollectionView.constraints)
        
        headerView.snp.makeConstraints{ make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(12)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.height.equalTo(24)
        }
        
        tagCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func updateHeaderViewContraintToInvisible(){
        
        headerView.removeConstraints(headerView.constraints)
        categoryLabel.removeConstraints(categoryLabel.constraints)
        tagCollectionView.removeConstraints(tagCollectionView.constraints)
        
        headerView.snp.makeConstraints{ make in
            make.size.equalTo(0)
        }
        categoryLabel.snp.makeConstraints{ make in
            make.edges.equalTo(0)
        }
        tagCollectionView.snp.makeConstraints{ make in
            make.edges.equalTo(0)
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

//MARK: - UISliding CollectionView 위치에 따른 동적인 뷰 구성을 위한 protocol 채택
extension SpotDetailViewController: SlidingTabControllerDelegate{
    
    func didSelectFirstVC() {
        // headerView 의 크기를 레이아웃에 맞게 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.updateHeaderViewContraintToVisible()
            self.view.layoutIfNeeded()
        }
    }
    
    func didSelectSecondVC() {
        // headerView 의 크기를 0으로 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.updateHeaderViewContraintToInvisible()
            self.view.layoutIfNeeded()
        }
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
    let time: String
    let description: String
    let recommends: [String]
    let menuImageUrls: [String]
}
