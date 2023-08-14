//
//  MoodBoardEditViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/14.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class MoodBoardEditViewController: UIViewController {
    
    let colorIcon :[UIImage?] = [UIImage(named: "color0"),UIImage(named: "color1"),UIImage(named: "color2"),UIImage(named: "color3"),UIImage(named: "color4"),UIImage(named: "color5"),UIImage(named: "color6"),UIImage(named: "color7"),UIImage(named: "color8"),UIImage(named: "color9"),UIImage(named: "color10")]
    
    //MARK: - UIComponents
    
    let closeBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    let drawBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "pencilIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    let textBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "textIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    let stickerBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "addStickerIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    let photoBtn = UIButton().then{
        $0.tintColor = .white
        $0.setImage(UIImage(named: "photoIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    let backgroundColorBtn = UIButton().then{
        $0.setImage(UIImage(named: "color0"), for: .normal)
    }
    
    let nextBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .darkBrown_30
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 47/2
    }
    
    let colorCollectionView = UICollectionView(frame: .init(), collectionViewLayout: UICollectionViewLayout()).then{
        $0.backgroundColor = .clear
        $0.isHidden = true
        $0.showsHorizontalScrollIndicator = false
        $0.allowsSelection = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
        $0.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellIdentifier)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .color0
        
        hierarchy()
        layout()
        
        //collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        self.colorCollectionView.collectionViewLayout = layout
        self.colorCollectionView.dataSource = self
        self.colorCollectionView.delegate = self
        
        //Button
        self.backgroundColorBtn.addTarget(self, action: #selector(backgroundColorBtnDidTab), for: .touchUpInside)

    }
    
    
    //MARK: - Actions
    
    @objc func backgroundColorBtnDidTab() {
        nextBtn.isHidden = true
        colorCollectionView.isHidden = false
    }
    
    
    //MARK: - Helpers

}

//MARK: - CollectionViewDelegate
extension MoodBoardEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if colorIcon.isEmpty{
        return 0
    }else {
        return colorIcon.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) as? ColorCell else{
        fatalError()
    }
    cell.layer.cornerRadius = 15
    cell.layer.masksToBounds = true
    cell.colorBtn.setImage(colorIcon[indexPath.row], for: .normal)
    cell.contentMode = .scaleAspectFit
    
//    cell.removeBtn.tag = indexPath.row
//    cell.removeBtn.addTarget(self, action: #selector(deletePictureBtnDidTab(_:)), for: .touchUpInside)

    return cell
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) as? ColorCell else{
        fatalError()
    }

    let size = CGSize(width: 28, height: 28)
    
    return size
}
}


struct MoodBoardEditVCPreView:PreviewProvider {
    static var previews: some View {
        MoodBoardEditViewController().toPreview()
    }
}

