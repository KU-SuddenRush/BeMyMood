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
        $0.tintColor = .white
        $0.setImage(UIImage(named: "color1")?.withRenderingMode(.alwaysTemplate), for: .normal)
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

    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .color0
        
        hierarchy()
        layout()

    }
    
    
    //MARK: - Actions
    
    
    //MARK: - Helpers

}


struct MoodBoardEditVCPreView:PreviewProvider {
    static var previews: some View {
        MoodBoardEditViewController().toPreview()
    }
}

