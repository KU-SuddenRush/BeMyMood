//
//  ViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let nextButton = UIButton().then{
        $0.setTitle("홈", for: .normal)
        $0.backgroundColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()
    }


}

