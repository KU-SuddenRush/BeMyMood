//
//  SpotListPageViewController.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/07.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        let firstPage = FirstViewController()
        let secondPage = SecondViewController()
        
        pages.append(firstPage)
        pages.append(secondPage)
        
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else {
            return nil
        }
        return pages[currentIndex + 1]
    }

}
