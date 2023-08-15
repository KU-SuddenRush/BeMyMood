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
//    let 
    let categoryLabel = UILabel().then{
        $0.backgroundColor = .lightGray
        $0.text = "default"
        $0.textColor = .orange
    }
    
    let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .blue
    }

//    let slidingTabVC = UISlidingTabController().then{
////        $0.addItem(item: SpotDetailInfoViewController(), title: "상세정보")
////        $0.addItem(item: SpotReview(), title: "리뷰")
//        $0.setHeaderActiveColor(color: .orange)
//        $0.setHeaderInActiveColor(color: .black)
//        $0.setHeaderBackgroundColor(color: .white)
//        $0.build()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
     }

}

extension SpotDetailViewController {
    
    func hierarchy(){
        self.view.addSubview(categoryLabel)
        self.view.addSubview(tagCollectionView)
    }
    func layout(){
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(10)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(30)
        }
        
        tagCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(100)
        }
    }
}

struct SpotDetailVCPreView:PreviewProvider {
    static var previews: some View {
        SpotDetailViewController().toPreview()
    }
}
