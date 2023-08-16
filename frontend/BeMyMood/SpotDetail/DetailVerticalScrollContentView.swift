//
//  DetailVerticalScrollContentView.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import UIKit

//MARK: - content
class DetailVerticalScrollContentView: UIView{
    
    var tempData: SpotDetailInfos!

    //MARK: - UIComponents : 사진 컬렉션뷰
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let imageCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCV.backgroundColor = .white
        imageCV.isPagingEnabled = true
        return imageCV
    }()
    
    //MARK: - UIComponents : 기본 정보
    let basicInfoView = UIView().then{
        $0.backgroundColor = .white
    }

    let info1Img = UIImageView().then{
        $0.tintColor = .lightGray
        $0.image = UIImage(systemName: "square.on.square")
    }
    let info1Title = UILabel().then{
        $0.text = "address"
        $0.backgroundColor = .white
    }
    let info2Img = UIImageView().then{
        $0.tintColor = .lightGray
        $0.image = UIImage(systemName: "link")
    }
    let info2Title = UILabel().then{
        $0.text = "url"
        $0.backgroundColor = .white
    }
    let info3Img = UIImageView().then{
        $0.tintColor = .lightGray
        $0.image = UIImage(systemName: "clock")
    }
    let info3Title = UILabel().then{
        $0.text = "time"
        $0.backgroundColor = .white
    }
    
    //MARK: - UIComponents : 상세 설명
    let descriptionView = UIView().then{
        $0.backgroundColor = .white
    }
    let digonal1 = UIImageView().then{
        $0.tintColor = .black
        $0.image = UIImage(systemName: "line.diagonal")
    }
    let digonal2 = UIImageView().then{
        $0.tintColor = .black
        $0.image = UIImage(systemName: "line.diagonal")
    }
    let descriptionText = UILabel().then{
        $0.numberOfLines = 20
        $0.text = "누데이크의 두 번째 플래그십 스토어인 성수점은 <Museum of Nudake>를 테마로 완성했습니다. 'Make New Fantasy'라는 슬로건을 담아 만든 오브제와 조형물을 중심으로 아티스틱한 경험과 새로운 감정을 선사합니다."
        $0.backgroundColor = .white
    }
    
    //MARK: - UIComponents : 즐길 거리
    let entertainmentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let entertainmentTitle = UILabel().then{
        $0.font = .boldSystemFont(ofSize: 16)
        $0.text = "즐길 거리"
    }
    let entertainmentSubtitle = UILabel().then{
        $0.text = "리뷰어들의 추천"
    }
    let entertainmentRecommendCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let recommendCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recommendCV.backgroundColor = .white
        recommendCV.showsHorizontalScrollIndicator = false
        return recommendCV
    }()
    let entertainmentMenu = UILabel().then{
        $0.text = "메뉴"
    }
    let entertainmentMenuCollecionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let menuCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        menuCV.backgroundColor = .white
        menuCV.showsHorizontalScrollIndicator = false
        return menuCV
    }()

    init(frame: CGRect, spotInfo: SpotDetailInfos) {
        super.init(frame: frame)
        self.tempData = spotInfo
        hierarchy()
        layout()
        dataInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hierarchy()
        layout()
        dataInit()
    }
    
    func dataInit(){
        setupImageCollectionView()
        info1Title.text = tempData.address
        info2Title.text = tempData.url
        info3Title.text = tempData.time
        
        descriptionText.text = tempData.description
        
        setupRecommendCollectionView()
        setupMenuCollectionView()
    }
    
    func hierarchy(){
        
        self.addSubview(imageCollectionView)
        
        self.addSubview(basicInfoView)
        basicInfoView.addSubview(info1Img)
        basicInfoView.addSubview(info1Title)
        basicInfoView.addSubview(info2Img)
        basicInfoView.addSubview(info2Title)
        basicInfoView.addSubview(info3Img)
        basicInfoView.addSubview(info3Title)
        
        self.addSubview(descriptionView)
        descriptionView.addSubview(digonal1)
        descriptionView.addSubview(descriptionText)
        descriptionView.addSubview(digonal2)
        
        self.addSubview(entertainmentView)
        entertainmentView.addSubview(entertainmentTitle)
        entertainmentView.addSubview(entertainmentSubtitle)
        entertainmentView.addSubview(entertainmentRecommendCollectionView)
        entertainmentView.addSubview(entertainmentMenu)
        entertainmentView.addSubview(entertainmentMenuCollecionView)
    }
    
    func layout(){
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(272)
        }
        
        basicInfoView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(80)
        }
        
        info1Img.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        info1Title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(info1Img.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        info2Img.snp.makeConstraints { make in
            make.top.equalTo(info1Img.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        info2Title.snp.makeConstraints { make in
            make.top.equalTo(info1Title.snp.bottom).offset(4)
            make.leading.equalTo(info2Img.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        info3Img.snp.makeConstraints { make in
            make.top.equalTo(info2Img.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        info3Title.snp.makeConstraints { make in
            make.top.equalTo(info2Title.snp.bottom).offset(4)
            make.leading.equalTo(info3Img.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }

        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(basicInfoView.snp.bottom).offset(14)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        digonal1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        descriptionText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(digonal1.snp.bottom).offset(14)
            make.bottom.equalTo(digonal2.snp.top).offset(-14)
        }
        digonal2.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
            make.size.equalTo(24)
        }
        
        entertainmentView.snp.makeConstraints{ make in
            make.top.equalTo(descriptionView.snp.bottom).offset(14)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(self.snp.bottom).offset(-30)
        }
        entertainmentTitle.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        entertainmentSubtitle.snp.makeConstraints{ make in
            make.top.equalTo(entertainmentTitle.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        entertainmentRecommendCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(entertainmentSubtitle.snp.bottom).offset(14)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(40)
        }
        entertainmentMenu.snp.makeConstraints{ make in
            make.top.equalTo(entertainmentRecommendCollectionView.snp.bottom).offset(14)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(24)
        }
        entertainmentMenuCollecionView.snp.makeConstraints{ make in
            make.top.equalTo(entertainmentMenu.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(138)
            make.bottom.equalToSuperview()
        }
        
    }
    
}

extension DetailVerticalScrollContentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupImageCollectionView() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
    }
    
    func setupRecommendCollectionView() {
        entertainmentRecommendCollectionView.dataSource = self
        entertainmentRecommendCollectionView.delegate = self
        entertainmentRecommendCollectionView.register(RecommendCell.self, forCellWithReuseIdentifier: "recommendCell")
    }
    
    func setupMenuCollectionView() {
        entertainmentMenuCollecionView.dataSource = self
        entertainmentMenuCollecionView.delegate = self
        entertainmentMenuCollecionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "menuCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case imageCollectionView:
            return tempData.spotThumbnailImageUrl.count
        case entertainmentRecommendCollectionView:
            return tempData.recommends.count
        case entertainmentMenuCollecionView:
            return tempData.menuImageUrls.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case imageCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
            
            let imageView = UIImageView(frame: cell.contentView.bounds)
            imageView.loadImage(from: tempData.spotThumbnailImageUrl[indexPath.row])
            cell.contentView.addSubview(imageView)
            
            return cell
            
        case entertainmentRecommendCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCell
            
            cell.recommmendImage.loadImage(from: "https://picsum.photos/200/300")
            cell.recommendLabel.text = tempData.recommends[indexPath.row]
            
            return cell

        case entertainmentMenuCollecionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath)
            
            let imageView = UIImageView(frame: cell.contentView.bounds)
            imageView.loadImage(from: tempData.menuImageUrls[indexPath.row])
            cell.contentView.addSubview(imageView)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func calculateTagCellWidth(for text: String) -> CGFloat {
        // 셀 폭을 계산하는 로직을 작성합니다. 텍스트의 길이에 따라 동적으로 폭을 설정하거나, 고정된 값으로 설정할 수 있습니다.
        let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16.0)]).width
        let cellWidth = textWidth
        
        return cellWidth
    }
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
        case imageCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case entertainmentRecommendCollectionView:
            let cellWidth = calculateTagCellWidth(for: tempData.recommends[indexPath.row]) + 82
            return CGSize(width: cellWidth + 5, height: collectionView.frame.height)
        case entertainmentMenuCollecionView:
            return CGSize(width: collectionView.frame.height, height: collectionView.frame.height) // 1:1
        default:
            return CGSize()
        }
    }
}
