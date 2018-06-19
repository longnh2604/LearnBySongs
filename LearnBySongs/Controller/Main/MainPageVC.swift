//
//  MainPageVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/06/19.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class MainPageVC: BasePageVC {
    
    var firstPageVC : UserViewController?
    var secondPageVC : SecondPageVC?
    
    lazy var orderedViewControllers: [UIViewController] = {
        firstPageVC = self.newVc(viewController: "UserViewController") as? UserViewController
//        firstPageVC?.pass_data_callback = {
//            pass_data in
//            self.secondPageVC?.receive_data = pass_data
//        }
        secondPageVC = self.newVc(viewController: "SecondPageVC") as? SecondPageVC
        
        return [firstPageVC!,
                secondPageVC!]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
}

//*****************************************************************
// MARK: - UIPageViewDelegate , Datasource
//*****************************************************************

extension MainPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            //            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}
