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
    let tagMoodData = ["#앤틱","#빈티지","#인더스트리얼","#식물이많은", "#힙한","#특이한소재","#어두운","#아기자기한","#포인트컬러","#모노톤의","#미니멀한","#연인과함께","#반려동물과함께","#우디","#복고풍의","#풍경위주의","#여유로운","#키치한","#친구와함께","#컬러풀한","#루프탑","#야경이예쁜","#고즈넉한","#한국적인","#고풍스러운","#별이보이는","#로컬의","#화려한조명","#한적한","#영화컨셉의","#이국적인","#은은한조명의","#Y2k","#LP가흐르는","#복고풍의","#무채색","#미래지향적인","#볼거리가 많은","#소품이많은","#밤과어울리는","#LP가흐르는","#복고풍의","#무채색","#미래지향적인","#볼거리가 많은","#소품이많은","#밤과어울리는"]
    
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
        if tagMoodData.isEmpty{
            return 0
        }else {
            return tagMoodData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.backgroundColor = .grayBeige
        cell.tagLabel.text = tagMoodData[indexPath.row]
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
        
        cell.tagLabel.text = tagMoodData[indexPath.row]
        
        cell.tagLabel.sizeToFit()

        let cellWidth = cell.tagLabel.frame.width + 40

        let size = CGSize(width: cellWidth, height: 30)

        return size
    }
}

struct MoodSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        MoodSelectionViewController().toPreview()
    }
}

