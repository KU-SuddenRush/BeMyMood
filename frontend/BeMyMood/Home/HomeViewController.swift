//
//  ViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let tagData = ["#풍경위주의","#힙한","#뮤트한", "#미니멀한","#반려동물과함께","#고즈넉한","#우디","#우디","#우디","#우디","#우디"]
    
    var lastTag = -1
    
    //MARK: - UIComponents
    
    let homeTitle = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "김건국님을 담을,"
    }
    
    let notificationBtn = UIButton().then{
        $0.setImage(UIImage(named: "notification"), for: .normal)
    }
    
    let moodCount = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .darkBrown
        $0.text = "무드 8"
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.allowsSelection = false
        $0.backgroundColor = .grayBeige
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.cellIdentifier)
    }
    
    let badgeCount = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .darkBrown
        $0.text = "뱃지 0"
    }
    
    let badgeBtn = UIButton().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "badge_empty"), for: .normal)
        $0.setImage(UIImage(named: "badge_empty"), for: .highlighted)
    }
    
    let badgeLabel = UILabel().then{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        $0.attributedText = NSMutableAttributedString(string: "나를 표현할\n뱃지를\n획득해보세요!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 3
        $0.textColor = .white
    }
    
    let star1 = UIImageView().then{
        $0.image = UIImage(named: "star")
    }
    
    let star2 = UIImageView().then{
        $0.image = UIImage(named: "star")
    }
    
    let star3 = UIImageView().then{
        $0.image = UIImage(named: "star")
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .grayBeige
        
        hierarchy()
        layout()
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.notificationBtn.addTarget(self, action: #selector(nextBtnDidTab), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        updateLastCell()
    }
    
    //MARK: - Actions
    
    @objc func nextBtnDidTab() {
        let colorSelectionViewController = ColorSelectionViewController()
        self.navigationController?.pushViewController(colorSelectionViewController, animated: true)
        
    }
    
    //MARK: - Helpers
    
    func updateLastCell() {
        var max = 0
        var maxItem = IndexPath()
        
        for cell in collectionView.visibleCells {
            
            if let indexPath = collectionView.indexPath(for: cell) {
                if max < indexPath.row {
                    max = indexPath.row
                    maxItem = indexPath
                }
            }
        }
        
        if let tagCell = collectionView.cellForItem(at: maxItem) as? TagCell {
            tagCell.tagLabel.backgroundColor = .darkBrown_80
            tagCell.tagLabel.text = "+" + String(tagData.count - max)
            tagCell.layoutIfNeeded()
            let newSize = CGSize(width: 50, height: 33)
            tagCell.frame.size = newSize
        }
    }


}
    //MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tagData.isEmpty{
            return 0
        }else {
            return tagData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        cell.tagLabel.backgroundColor = .darkBrown
        cell.tagLabel.layer.borderColor = UIColor.black.cgColor
        cell.tagLabel.text = tagData[indexPath.row]
        cell.tagLabel.textColor = .white
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.text = tagData[indexPath.row]
        
        cell.tagLabel.sizeToFit()

        let cellWidth = cell.tagLabel.frame.width + 32

        let size = CGSize(width: cellWidth, height: 33)
        
        return size
    }
}

struct HomeVCPreView:PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
