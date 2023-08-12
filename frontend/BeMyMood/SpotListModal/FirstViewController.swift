//
//  FirstViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import UIKit
import SwiftUI

class FirstViewController: UIViewController {

    //MARK: - UIComponents
    
    let filterSection = UIView().then{
        $0.backgroundColor = .lightGray
    }
    
    let spotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hierarchy()
        layout()
    }

}

extension FirstViewController {
    
    func hierarchy(){
        self.view.addSubview(filterSection)
        self.view.addSubview(spotCollectionView)
    }
    
    func layout(){
        filterSection.snp.makeConstraints{ make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50).priority(.high)
            make.bottom.equalTo(spotCollectionView.snp.top)
        }
        
        spotCollectionView.snp.makeConstraints{ make in
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}


struct FirstVCPreView:PreviewProvider {
    static var previews: some View {
        FirstViewController().toPreview()
    }
}
