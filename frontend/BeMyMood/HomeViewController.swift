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
    
    //MARK: - UIComponents
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "logo")
    }
    
    let notificationBtn = UIButton().then{
        $0.setImage(UIImage(named: "notification"), for: .normal)
    }
    
    let introduce = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.text = "김건국님의 무드8"
        
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#EAE9E5")
        
        hierarchy()
        layout()
    }


}

struct HomeVCPreView:PreviewProvider {
    static var previews: some View {
        HomeViewController().toPreview()
    }
}
