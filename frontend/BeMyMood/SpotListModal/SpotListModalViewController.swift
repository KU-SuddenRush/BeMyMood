//
//  SpotListModalViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class SpotListModalViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let spotListModalTitle = UILabel().then{
        $0.backgroundColor = .lightGray
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.textColor = .black
        
        $0.text = "내 무드를 담은 스팟"
    }
    
    let slidingTabVC = UISlidingTabController().then{
        $0.addItem(item: FirstViewController(), title: "모든무드")
        $0.addItem(item: SecondViewController(), title: "무드별")
        $0.setHeaderActiveColor(color: .white)
        $0.setHeaderInActiveColor(color: .lightText)
        $0.setHeaderBackgroundColor(color: .orange)
        $0.build()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hierarchy()
        layout()
    }

}

extension SpotListModalViewController {
    
    func hierarchy(){
        self.view.addSubview(spotListModalTitle)
        self.view.addSubview(slidingTabVC.view)
    }
    
    func layout(){
        spotListModalTitle.snp.makeConstraints{ make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        slidingTabVC.view.snp.makeConstraints{ make in
            make.top.equalTo(spotListModalTitle.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


struct SpotListModalVCPreView:PreviewProvider {
    static var previews: some View {
        SpotListModalViewController().toPreview()
    }
}
