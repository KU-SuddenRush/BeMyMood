//
//  MoodBoardViewController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit
import Then
import SnapKit
import SwiftUI

class MoodBoardViewController: UIViewController {
    
    //MARK: - UIComponents
    
    let moodBoardTitle = UILabel().then{
        $0.backgroundColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .black
        
        $0.text = "나의 무드보드"
    }
    
    let slidingTabVC = UISlidingTabController().then{
        $0.addItem(item: RecentMoodBoardViewController(), title: "최근")
        $0.addItem(item: StoredMoodBoardViewController(), title: "저장된")
        $0.setHeaderActiveColor(color: .orange)
        $0.setHeaderInActiveColor(color: .black)
        $0.setHeaderBackgroundColor(color: .white)
        $0.build()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if let recentVC = slidingTabVC.items[0] as? RecentMoodBoardViewController {
            recentVC.recentMBnavigationController = self.navigationController // yourData는 전달할 데이터입니다.
        }
        
        hierarchy()
        layout()

    }
    
    
    


}


struct MoodBoardVCPreView:PreviewProvider {
    static var previews: some View {
        MoodBoardViewController().toPreview()
    }
}
