//
//  PagingMenuVC.swift
//  LearnBySongs
//
//  Created by Long Nguyen on 2018/03/21.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import Parchment

class PagingMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load each of the view controllers you want to embed
        // from the storyboard.
        let storyboard = UIStoryboard(name: "Sub", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "VideoDetailVC")
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "NewWordsVC")
        
        // Initialize a FixedPagingViewController and pass
        // in the view controllers.
        let pagingViewController = FixedPagingViewController(viewControllers: [
            firstViewController,
            secondViewController
            ])
        
        // Make sure you add the PagingViewController as a child view
        // controller and contrain it to the edges of the view.
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        view.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParentViewController: self)
    }
}
