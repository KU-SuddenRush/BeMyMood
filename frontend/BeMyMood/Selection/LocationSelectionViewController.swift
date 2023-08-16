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
        $0.progressTintColor = .darkBrown_50
        $0.trackTintColor = .darkBrown_30
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
    
    let searchBar1 = UIButton().then{
        $0.setTitle("지역 1", for: .normal)
        $0.setTitleColor(.orange, for: .selected)
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    }
    
    let searchBar2 = UIButton().then{
        $0.setTitle("지역 2", for: .normal)
        $0.setTitleColor(.orange, for: .selected)
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    }
    
    let searchBar3 = UIButton().then{
        $0.setTitle("지역 3", for: .normal)
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.setTitleColor(.orange, for: .selected)
        $0.layer.borderColor = UIColor.darkBrown_30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 50/2
        $0.contentHorizontalAlignment = .left
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
    }
    
    let locationSearchBtn = UIButton().then{
        $0.setTitle("현재 위치로 찾기", for: .normal)
        $0.backgroundColor = .grayBeige
        $0.setTitleColor(.darkBrown, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.titleLabel?.textAlignment = .center
        $0.layer.cornerRadius = 15
        
        let iconImage = UIImage(named: "location") // 원하는 아이콘 이미지로 변경
            $0.setImage(iconImage, for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 아이콘 위치 조정
    }
    
    let nextBtn = UIButton().then{
        $0.isEnabled = false
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = .darkBrown_30
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
        checkBtnStatus()
        
        self.searchBar1.addTarget(self, action: #selector(searchBar1BtnDidTab), for: .touchUpInside)
        
        self.searchBar2.addTarget(self, action: #selector(searchBar2BtnDidTab), for: .touchUpInside)
        
        self.searchBar3.addTarget(self, action: #selector(searchBar3BtnDidTab), for: .touchUpInside)

        self.nextBtn.addTarget(self, action: #selector(nextBtnDidTab), for: .touchUpInside)
    }
    
    
    //MARK: - Actions
    @objc func searchBar1BtnDidTab() {
        let locationSelectionViewController = LocationSearchViewController()
        locationSelectionViewController.completionHandler = {result in
            self.searchBar1.setTitle(result, for: .normal)
            self.searchBar1.layer.borderColor = UIColor.orange.cgColor
            self.searchBar1.isSelected = true
            self.checkBtnStatus()
            }
        self.navigationController?.pushViewController(locationSelectionViewController, animated: true)
    }
    
    @objc func searchBar2BtnDidTab() {
        let locationSelectionViewController = LocationSearchViewController()
        locationSelectionViewController.completionHandler = {result in
            self.searchBar2.setTitle(result, for: .normal)
            self.searchBar2.layer.borderColor = UIColor.orange.cgColor
            self.searchBar2.isSelected = true
            self.checkBtnStatus()
            }
        self.navigationController?.pushViewController(locationSelectionViewController, animated: true)
    }
    
    @objc func searchBar3BtnDidTab() {
        let locationSelectionViewController = LocationSearchViewController()
        locationSelectionViewController.completionHandler = {result in
            self.searchBar3.setTitle(result, for: .normal)
            self.searchBar3.layer.borderColor = UIColor.orange.cgColor
            self.searchBar3.isSelected = true
            self.checkBtnStatus()
            }
        self.navigationController?.pushViewController(locationSelectionViewController, animated: true)
    }
    
    @objc func nextBtnDidTab() {
        let homeVC = TabBarController()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    //MARK: - Helpers
    func checkBtnStatus(){
        if searchBar1.isSelected && searchBar2.isSelected && searchBar3.isSelected {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .darkBrown
        }else{
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .darkBrown_30
        }
    }

}


struct LocationSelectionVCPreView:PreviewProvider {
    static var previews: some View {
        LocationSelectionViewController().toPreview()
    }
}

