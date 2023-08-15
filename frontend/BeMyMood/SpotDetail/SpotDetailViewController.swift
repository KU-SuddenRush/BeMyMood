//
//  SpotDetailViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/14.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class SpotDetailViewController: UIViewController {
    
    //MARK: - UIComponents
    let categoryLabel = UILabel().then{
        $0.backgroundColor = .lightGray
        $0.text = "Category Label"
        $0.textColor = .orange
    }
    
    let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .blue
    }
    
    let slidingTabVC = UISlidingTabController().then{
        $0.addItem(item: DetailViewController(), title: "상세정보")
        $0.addItem(item: UIViewController(), title: "리뷰")
        $0.setHeaderActiveColor(color: .orange)
        $0.setHeaderInActiveColor(color: .black)
        $0.setHeaderBackgroundColor(color: .white)
        $0.build()
    }
    
    let addModeBoardView = UIView().then{
        $0.backgroundColor = .purple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemTeal
        
        hierarchy()
        layout()
    }
    
}

extension SpotDetailViewController{
    
    func hierarchy(){
        self.view.addSubview(categoryLabel)
        self.view.addSubview(tagCollectionView)
        self.view.addSubview(slidingTabVC.view)
        self.view.addSubview(addModeBoardView)
    }
    
    func layout(){
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(20)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.height.equalTo(24)
        }
        
        tagCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(60)
        }
        
        slidingTabVC.view.snp.makeConstraints{ make in
            make.top.equalTo(tagCollectionView.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(addModeBoardView.snp.top)
        }
        
        addModeBoardView.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(104)
        }
    }
}

struct SpotDetailVCPreView:PreviewProvider {
    static var previews: some View {
        SpotDetailViewController().toPreview()
    }
}
