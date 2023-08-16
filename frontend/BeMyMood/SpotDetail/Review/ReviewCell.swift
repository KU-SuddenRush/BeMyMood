//
//  ReviewCell.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/16.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    var reviewImageUrls: [String]?

    //MARK: - UIComponents
    let reviewBasicInfoView = UIView().then {
        $0.backgroundColor = .white
    }
    var profileImage = UIImageView().then{
        $0.layer.cornerRadius = 24 / 2 // issue: 왜 변수론 안되니. init 에서 호출해도
        $0.clipsToBounds = true
    }
    var nickname = UILabel().then{
        $0.font = .boldSystemFont(ofSize: 16)
    }
    var postedAt = UILabel().then{
        $0.textAlignment = .right
        $0.font = UIFont(name: "AppleSDGothicNeoR00-Regular", size: 12)
    }
    
    let reviewImageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let reviewImagesCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        reviewImagesCV.backgroundColor = .white
        return reviewImagesCV
    }()
    
    var reviewText = UILabel().then{
        $0.numberOfLines = 20
        $0.backgroundColor = .white
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 셀의 초기화 코드
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        // Interface Builder로 셀을 생성할 때 사용될 초기화 코드
        commonInit()
    }

    func commonInit(){
        
        hierarchy()
        layout()
        
        setupImageCollectionView()
    }
    
    func hierarchy(){
        self.contentView.addSubview(reviewBasicInfoView)
        reviewBasicInfoView.addSubview(profileImage)
        reviewBasicInfoView.addSubview(nickname)
        reviewBasicInfoView.addSubview(postedAt)
        
        self.contentView.addSubview(reviewImageCollectionView)
        self.contentView.addSubview(reviewText)
    }
    
    func layout(){
        reviewBasicInfoView.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(68)
        }
        
        profileImage.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(24)
            make.size.equalTo(24)
        }
        
        nickname.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.height.equalTo(24)
        }
        
        postedAt.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(100)
            make.height.equalTo(21)
            make.leading.equalTo(nickname.snp.trailing).offset(30)
            
        }
        
        reviewImageCollectionView.snp.makeConstraints{ make in
            make.leading.equalTo(24)
            make.trailing.equalToSuperview()
            make.top.equalTo(reviewBasicInfoView.snp.bottom)
            make.height.equalTo(140)
        }
        
        reviewText.snp.makeConstraints{ make in
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.top.equalTo(reviewImageCollectionView.snp.bottom).offset(21)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
        }
    }

    
}

extension ReviewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func setupImageCollectionView() {
        self.reviewImageCollectionView.dataSource = self
        self.reviewImageCollectionView.delegate = self
        self.reviewImageCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewImageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.loadImage(from: reviewImageUrls?[indexPath.row] ?? "https://picsum.photos/200/300")
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    // CollectionView Cell의 Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height + 23, height: collectionView.frame.height)
    }
}
