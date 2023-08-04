//
//  SceneDelegate.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        self.navigationController = UINavigationController(rootViewController: createTabBarController())
        self.navigationController?.navigationBar.isHidden = true
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
    func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [createFirstViewController(), createSecondViewController(), createThirdViewController(),createFourViewController()]
            return tabBarController
        }
        
        func createFirstViewController() -> UIViewController {
            let firstViewController = HomeViewController()
            firstViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "circle"), tag: 0)
            return firstViewController
        }
        
        func createSecondViewController() -> UIViewController {
            let secondViewController = MoodBoardViewController()
            secondViewController.tabBarItem = UITabBarItem(title: "무드보드", image: UIImage(named: "circle"), tag: 1)
            return secondViewController
        }
        
        func createThirdViewController() -> UIViewController {
            let thirdViewController = CommunityViewController()
            thirdViewController.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(named: "circle"), tag: 2)
            return thirdViewController
        }
    
    func createFourViewController() -> UIViewController {
        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "내프로필", image: UIImage(named: "circle"), tag: 2)
        return thirdViewController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

