//
//  ColorSelectionViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/08.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class ColorSelectionViewController: UIViewController {
    
    var colorData : [Int] = []
    
    var selectData : [Int] = []
    
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
        $0.progress = 1/3
    }
    
    let label = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "좋아하는 색상을 알려주세요"
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
        
        swipeRecognizer()
        
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
        
        ApiClient().getTotalColor { result in
            self.colorData = result
            self.collectionView.reloadData()
        }
        
    }
    
    //MARK: - Actions
    
    @objc func nextBtnDidTab() {
        print("선택데이터",selectData)
        ApiClient().postMyMood(PostMyMoodInput(moodIds: selectData)) { result in
            if !result.contains("fail"){
                let moodSelectionViewController = MoodSelectionViewController()
                self.navigationController?.pushViewController(moodSelectionViewController, animated: true)
            }
        }
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction{
                case UISwipeGestureRecognizer.Direction.right:
                    // 스와이프 시, 뒤로가기
                    self.navigationController?.popViewController(animated: true)
                default: break
                }
            }
        }
    
    func swipeRecognizer() {
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
            
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

extension ColorSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if colorData.isEmpty{
            return 0
        }else {
            return colorData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.backgroundColor = .grayBeige
        cell.tagLabel.text = Data.moodData[colorData[indexPath.row] - 1]
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
        
        selectData.append(colorData[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        cell.isSelected = false
        isAnyCellSelected = collectionView.indexPathsForSelectedItems?.isEmpty == false
        updateNextBtnColor()
        selectData = selectData.filter { $0 != colorData[indexPath.row] }
        
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
        
        cell.tagLabel.text = Data.moodData[self.colorData[indexPath.row] - 1]
        
        cell.tagLabel.sizeToFit()

        let cellWidth = cell.tagLabel.frame.width + 30

        let size = CGSize(width: cellWidth, height: 30)

        return size
    }
}

struct ColorSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        ColorSelectionViewController().toPreview()
    }
}
