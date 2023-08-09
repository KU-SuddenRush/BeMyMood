//
//  LocationSelectionViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/09.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class LocationSelectionViewController: UIViewController {
    
    //MARK: - UIComponents
   
    let progressBar = UIProgressView().then{
        $0.progressViewStyle = .default
        $0.progressTintColor = .black_50
        $0.trackTintColor = .grayBeige
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4/2
        $0.clipsToBounds = true
        $0.layer.sublayers![1].cornerRadius = 4/2
        $0.subviews[1].clipsToBounds = true
        $0.progress = 1
    }
    
    let label = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "선호하는 지역을 알려주세요"
    }
    
    let nextBtn = UIButton().then{
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
    }

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        hierarchy()
        layout()

    }
    
    
    //MARK: - Btn


}

struct LocationSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        LocationSelectionViewController().toPreview()
    }
}

