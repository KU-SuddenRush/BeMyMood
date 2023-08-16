//
//  StoredMoodBoardViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/16.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class StoredMoodBoardViewController: UIViewController {
    
    var storedMBnavigationController: UINavigationController!
    var moodBoards : [MyRecentMoodBoard] = []
    
    //MARK: - UIComponents
    
    let count = UILabel().then{
        $0.text = "5개의 무드보드"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        
    }
    
    let selectBtn = UIButton().then{
        $0.setTitle("선택", for: .normal)
        $0.layer.cornerRadius = 25/2
        $0.backgroundColor = .grayBeige
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.titleLabel?.textAlignment = .center
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(MoodBoardCell.self, forCellWithReuseIdentifier: MoodBoardCell.cellIdentifier)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = false
        
        ApiClient().getMyMoodBoards(){ result in
            self.count.text = "\(result.moodBoards.count)개의 무드보드"
            self.moodBoards = result.moodBoards
            self.collectionView.reloadData()
        }
//
//        self.makeBtn.addTarget(self, action: #selector(makeBtnDidTab), for: .touchUpInside)
    }
    
//    @objc func makeBtnDidTab() {
//        let moodBoardEditVC = MoodBoardEditViewController()
//        self.recentMBnavigationController?.pushViewController(moodBoardEditVC, animated: true)
//    }
    
    
}

extension StoredMoodBoardViewController {
    
    func hierarchy(){
        self.view.addSubview(count)
        self.view.addSubview(selectBtn)
        
        self.view.addSubview(collectionView)
    }
    
    func layout(){
        count.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(24)
        }
        
        selectBtn.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(53)
            make.height.equalTo(25)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(count.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(15.5)
            make.trailing.equalToSuperview().offset(-15.5)
            make.bottom.equalToSuperview()
        }
    }
}

extension StoredMoodBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if moodBoards.isEmpty{
        return 0
    }else {
        return moodBoards.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodBoardCell.cellIdentifier, for: indexPath) as? MoodBoardCell else{
        fatalError()
    }
    if let imageUrl = URL(string: moodBoards[indexPath.row].moodBoardCaptureUrl) {
        cell.moodBoard.kf.setImage(with: imageUrl, placeholder: UIImage(named: "back"))
        cell.moodBoard.contentMode = .scaleAspectFill
    }
    
    return cell
}
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 169, height: 203)
        
        return size
    }
}
