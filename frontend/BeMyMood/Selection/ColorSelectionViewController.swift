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
    
    let tagColorData = ["#뮤트한","#비비드한","#차분한","#빛바랜", "#무채색의","#쿨한","#포인트컬러","#자연적인","#투명한","#형광의","#웜한","#블랙앤화이트"]
    
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
        $0.showsVerticalScrollIndicator = false
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.cellIdentifier)
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
        
        self.nextBtn.addTarget(self, action: #selector(nextBtnDidTab), for: .touchUpInside)
        
        
        
    }
    func swipeRecognizer() {
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
            swipeRight.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRight)
            
        }
    
    //MARK: - Actions
    
    @objc func nextBtnDidTab() {
        let moodSelectionViewController = MoodSelectionViewController()
        self.navigationController?.pushViewController(moodSelectionViewController, animated: true)
        
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

}





    //MARK: - CollectionViewDelegate

extension ColorSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tagColorData.isEmpty{
            return 0
        }else {
            return tagColorData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.backgroundColor = .grayBeige
        cell.tagLabel.text = tagColorData[indexPath.row]
        cell.tagLabel.textColor = .darkBrown
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.isSelected = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        cell.isSelected = false
        
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
        
        cell.tagLabel.text = tagColorData[indexPath.row]
        
        cell.tagLabel.sizeToFit()

        let cellWidth = cell.tagLabel.frame.width + 40

        let size = CGSize(width: cellWidth, height: 30)

        return size
    }
}

struct ColorSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        ColorSelectionViewController().toPreview()
    }
}
