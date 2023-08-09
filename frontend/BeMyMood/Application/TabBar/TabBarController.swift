//
//  TabBarController.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/07.
//

import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        whiteBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(whiteBackgroundView)
        
        NSLayoutConstraint.activate([
            whiteBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteBackgroundView.heightAnchor.constraint(equalToConstant: 90) // 원하는 높이로 설정
        ])
        
        self.viewControllers = [createFirstViewController(), createSecondViewController(), createThirdViewController(),createFourViewController()]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.viewControllers = [createFirstViewController(), createSecondViewController(), createThirdViewController(),createFourViewController()]
    }
    
    func createFirstViewController() -> UIViewController {
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
        firstViewController.tabBarItem.selectedImage = UIImage(named: "home_select")?.withRenderingMode(.alwaysOriginal)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#9A9A9A"),
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        firstViewController.tabBarItem.setTitleTextAttributes(attributes , for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        firstViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        firstViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        firstViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        return firstViewController
    }
    
    func createSecondViewController() -> UIViewController {
        let secondViewController = MoodBoardViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "무드보드", image: UIImage(named: "moodBoard"), tag:1)
        secondViewController.tabBarItem.selectedImage = UIImage(named: "moodBoard_select")?.withRenderingMode(.alwaysOriginal)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#9A9A9A"),
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        secondViewController.tabBarItem.setTitleTextAttributes(attributes , for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        secondViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        secondViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        secondViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        return secondViewController
    }
    
    func createThirdViewController() -> UIViewController {
        let thirdViewController = CommunityViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(named: "community"), tag:2)
        thirdViewController.tabBarItem.selectedImage = UIImage(named: "community_select")?.withRenderingMode(.alwaysOriginal)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#9A9A9A"),
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        thirdViewController.tabBarItem.setTitleTextAttributes(attributes , for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        thirdViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        thirdViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        thirdViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        return thirdViewController
    }
    
    func createFourViewController() -> UIViewController {
        let fourViewController = ProfileViewController()
        fourViewController.tabBarItem = UITabBarItem(title: "내프로필", image: UIImage(named: "profile"), tag: 3)
        fourViewController.tabBarItem.selectedImage = UIImage(named: "profile_select")?.withRenderingMode(.alwaysOriginal)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#9A9A9A"),
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        fourViewController.tabBarItem.setTitleTextAttributes(attributes , for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ]
        fourViewController.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        fourViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        fourViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 10)
        return fourViewController
    }
}
