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
    
    
    
    var isColorSelected = false
    
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
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.cellIdentifier)
        $0.isUserInteractionEnabled = true
        $0.allowsMultipleSelection = false
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
        if isColorSelected {
            nextBtn.isHidden = false
            colorCollectionView.isHidden = true
            isColorSelected.toggle()
        }else {
            nextBtn.isHidden = true
            colorCollectionView.isHidden = false
            isColorSelected.toggle()
        }
        
    }
    
    
    //MARK: - Helpers
    func backgroundColorBtnStatus(){
        if backgroundColorBtn.currentImage == UIImage.colorIcon[3] || backgroundColorBtn.currentImage == UIImage.colorIcon[4] || backgroundColorBtn.currentImage == UIImage.colorIcon[6]{
            closeBtn.tintColor = .black
            drawBtn.tintColor = .black
            textBtn.tintColor = .black
            stickerBtn.tintColor = .black
            photoBtn.tintColor = .black
        }else {
            closeBtn.tintColor = .white
            drawBtn.tintColor = .white
            textBtn.tintColor = .white
            stickerBtn.tintColor = .white
            photoBtn.tintColor = .white
        }
    }

}

//MARK: - CollectionViewDelegate
extension MoodBoardEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if UIImage.colorIcon.isEmpty{
        return 0
    }else {
        return UIImage.colorIcon.count
    }
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) as? ColorCell else{
        fatalError()
    }
    cell.colorBtn.image = UIImage.colorIcon[indexPath.row]
    cell.contentMode = .scaleAspectFit

    return cell
}


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else {
            fatalError()
        }
        cell.isSelected.toggle() // 셀의 isSelected 상태를 변경
        cell.row = indexPath.row
        self.view.backgroundColor = UIColor.colorList[indexPath.row]
        self.backgroundColorBtn.setImage(UIImage.colorIcon[indexPath.row], for: .normal)
        backgroundColorBtnStatus()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else {
            fatalError()
        }
        cell.isSelected.toggle()
        cell.colorBtn.image = UIImage.colorIcon[indexPath.row]
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.cellIdentifier, for: indexPath) as? ColorCell else{
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

