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
    
    let pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        hierarchy()
        layout()
    }

}

extension SpotListModalViewController {
    
    func hierarchy(){
        self.view.addSubview(spotListModalTitle)
        
        addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func layout(){
        spotListModalTitle.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.leading.top.trailing.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        pageViewController.view.snp.makeConstraints{ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(spotListModalTitle.snp.bottom)
        }
    
    }
}


struct SpotListModalVCPreView:PreviewProvider {
    static var previews: some View {
        SpotListModalViewController().toPreview()
    }
}
