//
//  MoodSelectionViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/08.
//


import UIKit
import Then
import SnapKit
import SwiftUI

class MoodSelectionViewController: UIViewController {
    var moodData : [Int] = []
    
    var isAnyCellSelected = false
    
    //MARK: - UIComponents
   
    let progressBar = UIProgressView().then{
        $0.progressViewStyle = .default
        $0.progressTintColor = .darkBrown_50
        $0.trackTintColor = .darkBrown_30
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4/2
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 4/2
        $0.subviews[1].clipsToBounds = true
        $0.progress = 2/3
    }
    
    let label = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "좋아하는 분위기를 알려주세요"
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = true
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.cellIdentifier)
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    
    let nextBtn = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .darkBrown_30
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
        
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 10
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
        
        updateNextBtnColor()
        self.nextBtn.addTarget(self, action: #selector(nextBtnDidTab), for: .touchUpInside)
        
        ApiClient().getTotalMood { result in
            self.moodData = result
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: - Actions
    
    @objc func nextBtnDidTab() {
        let locationSelectionViewController = LocationSelectionViewController()
        self.navigationController?.pushViewController(locationSelectionViewController, animated: true)
        
    }
    
    //MARK: - Helpers
    
    func updateNextBtnColor() {
        if isAnyCellSelected {
            // 선택된 셀이 있을 때
            nextBtn.backgroundColor = .darkBrown
            nextBtn.isEnabled = true
        } else {
            // 선택된 셀이 없을 때
            nextBtn.backgroundColor = .darkBrown_30
            nextBtn.isEnabled = false
        }
    }
    
    
}




    //MARK: - CollectionViewDelegate

extension MoodSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moodData.isEmpty{
            return 0
        }else {
            return moodData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.backgroundColor = .grayBeige
        cell.tagLabel.text = Data.moodData[self.moodData[indexPath.row] - 1]
        cell.tagLabel.textColor = .darkBrown
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.isSelected = true
        isAnyCellSelected = true
        updateNextBtnColor()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        cell.isSelected = false
        isAnyCellSelected = collectionView.indexPathsForSelectedItems?.isEmpty == false
        updateNextBtnColor()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
           if cell.isSelected {
               collectionView.deselectItem(at: indexPath, animated: true)
               return false
           } else {
               return true
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.text = Data.moodData[self.moodData[indexPath.row] - 1]
        
        cell.tagLabel.sizeToFit()

        let cellWidth = cell.tagLabel.frame.width + 30

        let size = CGSize(width: cellWidth, height: 30)

        return size
    }
}

struct MoodSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        MoodSelectionViewController().toPreview()
    }
}

