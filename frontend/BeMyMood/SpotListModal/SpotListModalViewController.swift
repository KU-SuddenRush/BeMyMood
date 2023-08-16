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
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "내 무드를 담은 스팟"
    }
    
    let slidingTabVC = UISlidingTabController().then{
        $0.addItem(item: FirstViewController(), title: "모든무드")
        $0.addItem(item: SecondViewController(), title: "무드별")
        $0.setHeaderActiveColor(color: .orange)
        $0.setHeaderInActiveColor(color: .black)
        $0.setHeaderBackgroundColor(color: .white)
        $0.build()
    }
//    let slidingTabVC = UISlidingTabController().then{
//        $0.setHeaderActiveColor(color: .orange)
//        $0.setHeaderInActiveColor(color: .black)
//        $0.setHeaderBackgroundColor(color: .white)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hierarchy()
        layout()
        
        self.view.layer.cornerRadius = 30
        self.view.layer.masksToBounds = true
        
//        let firstVC = FirstViewController()
//        firstVC.delegate = self
//        let secondVC = SecondViewController()
//        secondVC.delegate = self
//
//        slidingTabVC.addItem(item: firstVC, title: "모든무드")
//        slidingTabVC.addItem(item: secondVC, title: "무드별")
//        slidingTabVC.build()
//
        setUpSheetVC()
    }

}

extension SpotListModalViewController {
    
    func hierarchy(){
        self.view.addSubview(spotListModalTitle)
        self.view.addSubview(slidingTabVC.view)
    }
    
    func layout(){
        spotListModalTitle.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        slidingTabVC.view.snp.makeConstraints{ make in
            make.top.equalTo(spotListModalTitle.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//extension SpotListModalViewController: SpotCellTapDelegate{
//    func moveToSpotDetail(spotId: Int) {
//        print("## SpotListModalViewController SpotCellTapDelegate and spotId is \(spotId)")
//    }
//}

extension SpotListModalViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        print("&&&&&&&&")
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        
        let fullSizeDetent: UISheetPresentationController.Detent = .large()
        let middleSizeDetent: UISheetPresentationController.Detent = .medium()
        //        let defaultSizeDetent: UISheetPresentationController.Detent = .custom(resolver: .)
        //            .detent(withIdentifier: "Test2", constant: UIScreen.main.bounds.size.height - (95 + 41) ) //790 - 41
        
        
//        let detentIdentifier :UISheetPresentationController.Detent.Identifier = UISheetPresentationController.Detent.Identifier(rawValue: "Test2")
        
        controller.detents = [fullSizeDetent, middleSizeDetent]
        controller.preferredCornerRadius = 30
        controller.largestUndimmedDetentIdentifier = .medium
        controller.prefersScrollingExpandsWhenScrolledToEdge = true
        
//        self.slidingTabVC.view.layoutIfNeeded()
//        self.view.layoutIfNeeded()
        
        
        return controller
    }
    
    func setUpSheetVC(){
        isModalInPresentation = true
        modalPresentationStyle = .custom
        transitioningDelegate = self
        self.presentationController?.delegate = self
    }
}

extension SpotListModalViewController: UISheetPresentationControllerDelegate {
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        // 시트의 Detent가 변경될 때 호출됩니다.
        print("Detent가 변경되었습니다.")
        // 예를 들어, Detent가 변경될 때 페이지 컬렉션 뷰의 셀 크기를 조정하는 등의 작업을 수행할 수 있습니다.
        // 해당 동작을 구현하세요.
        print("collectionView.frame at change detent \(slidingTabVC.collectionPage.frame)")
        self.slidingTabVC.collectionPage.layoutIfNeeded()
        self.slidingTabVC.collectionPage.reloadData()
        
        print("collectionView.frame after reloadData \(slidingTabVC.collectionPage.frame)")
    }
}
    
struct SpotListModalVCPreView:PreviewProvider {
    static var previews: some View {
        SpotListModalViewController().toPreview()
    }
}
