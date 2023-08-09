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
    
    let tagData = ["#풍경위주의","#힙한","#무채색","#뮤트한", "#미니멀한","#고즈넉한","#포인트컬러","#LP가흐르는","#우디"]
    
    //MARK: - UIComponents
    
    let logo = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "logo")
    }
    
    let notificationBtn = UIButton().then{
        $0.setImage(UIImage(named: "notification"), for: .normal)
    }
    
    let introduce = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.text = "김건국님의 무드8"
    }
    
    let collectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.allowsSelection = false
        $0.backgroundColor = .grayBeige
        $0.showsVerticalScrollIndicator = false
        $0.register(TagCell.self, forCellWithReuseIdentifier: TagCell.cellIdentifier)
    }
    
    let star1 = UIImageView().then{
        $0.image = UIImage(named: "star")
    }
    
    let star2 = UIImageView().then{
        $0.image = UIImage(named: "star")
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .grayBeige
        
        hierarchy()
        layout()
        
        let layout = CenterAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.notificationBtn.addTarget(self, action: #selector(nextBtnDidTab), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc func nextBtnDidTab() {
        let colorSelectionViewController = ColorSelectionViewController()
        self.navigationController?.pushViewController(colorSelectionViewController, animated: true)
        
    }


}

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
        cell.tagLabel.backgroundColor = .grayBeige
        cell.tagLabel.layer.borderColor = UIColor.black.cgColor
        cell.tagLabel.text = tagData[indexPath.row]
        cell.tagLabel.textColor = .black
        
        if(indexPath.row % 2 == 0 ){
            cell.tagLabel.backgroundColor = .black
            cell.tagLabel.textColor = .white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.cellIdentifier, for: indexPath) as? TagCell else{
            fatalError()
        }
        
        cell.tagLabel.text = tagData[indexPath.row]
        
        cell.tagLabel.sizeToFit()

        let cellWidth = cell.tagLabel.frame.width + 40

        let size = CGSize(width: cellWidth, height: 30)

        return size
    }
}

struct HomeVCPreView:PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
