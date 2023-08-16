//
//  MoodBoardImageViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/17.
//
import UIKit
import Then
import SnapKit
import Kingfisher

class MoodBoardImageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var moodBoardImages : [String] = []
    
    var images : [String] = []
    var spots : [String] = []
    
    var completionHandler: ((String) -> ())?
    
    //MARK: - UIComponents
    let screenWidth = UIScreen.main.bounds.width
    
    let closeBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "backArrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    let name = UILabel().then{
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "이미지 첨부"
    }
    
    let imageBtn = UIButton().then{
        $0.setTitle("기록된 이미지", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.orange, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textAlignment = .center
    }
    
    let spotBtn = UIButton().then{
        $0.setTitle("스팟 시그니처", for: .normal)
        $0.backgroundColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.titleLabel?.textAlignment = .center
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(MoodBoardImageCell.self, forCellWithReuseIdentifier: MoodBoardImageCell.cellIdentifier)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .darkBrown
        
        hierarchy()
        layout()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical 
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = false
        
        ApiClient().getMyRecordImage() { result in
            if !result.reviewImageParams.isEmpty{
                
                for i in result.reviewImageParams{
                    self.images.append(i.reviewImgUrl)
                }
                self.moodBoardImages = self.images
                self.collectionView.reloadData()
            }
        }
        
        ApiClient().getMySpotImage() { result in
            if !result.spotSignatureImageParams.isEmpty{
                for i in result.spotSignatureImageParams{
                    self.spots.append(i.spotImgUrl)
                }
                self.moodBoardImages = self.spots
            }
        }
        
        setupGestureRecognizerOnCollection()

        self.imageBtn.addTarget(self, action: #selector(imageBtnDidTab), for: .touchUpInside)
        self.spotBtn.addTarget(self, action: #selector(spotBtnDidTab), for: .touchUpInside)
        self.closeBtn.addTarget(self, action: #selector(closeBtnDidTab), for: .touchUpInside)
    }
    
    
    
    @objc func imageBtnDidTab() {
        imageBtn.setTitleColor(.orange, for: .normal)
        spotBtn.setTitleColor(.white, for: .normal)
        moodBoardImages = images
        collectionView.reloadData()
    }
    
    @objc func spotBtnDidTab() {
        
        imageBtn.setTitleColor(.white, for: .normal)
        spotBtn.setTitleColor(.orange, for: .normal)
        moodBoardImages = spots
        print("스팟",spots)
        collectionView.reloadData()
    }
    
    @objc func closeBtnDidTab() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //스티커뷰 선택 제스쳐
    func setupGestureRecognizerOnCollection() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSticker(gestureRecognizer:)))
        tapGesture.delegate = self
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapSticker(gestureRecognizer: UIGestureRecognizer) {

        let p = gestureRecognizer.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: p) {
            self.navigationController?.popViewController(animated: true)
            completionHandler?(moodBoardImages[indexPath.row])
        }
    }
    
}

extension MoodBoardImageViewController {
    
    func hierarchy(){
        self.view.addSubview(closeBtn)
        self.view.addSubview(name)
        self.view.addSubview(imageBtn)
        self.view.addSubview(spotBtn)
        self.view.addSubview(collectionView)
    }
    
    func layout(){
        
        closeBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(24)
        }
        
        name.snp.makeConstraints{ make in
            make.centerY.equalTo(closeBtn)
            make.leading.equalTo(closeBtn.snp.trailing).offset(10)
            make.height.equalTo(24)
        }
        
        imageBtn.snp.makeConstraints{ make in
            make.top.equalTo(name.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.width.equalTo(screenWidth/2)
            make.height.equalTo(44)
        }
        
        spotBtn.snp.makeConstraints{ make in
            make.top.equalTo(name.snp.bottom).offset(15)
            make.trailing.equalToSuperview()
            make.width.equalTo(screenWidth/2)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(spotBtn.snp.bottom).offset(70)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension MoodBoardImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if moodBoardImages.isEmpty{
        return 0
    }else {
        return moodBoardImages.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodBoardImageCell.cellIdentifier, for: indexPath) as? MoodBoardImageCell else{
        fatalError()
    }
    if let imageUrl = URL(string: moodBoardImages[indexPath.row]) {
        cell.moodBoardImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "profile"))
        cell.moodBoardImage.contentMode = .scaleToFill
    }
    
    return cell
}
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 125, height: 180)
        
        return size
    }
}
