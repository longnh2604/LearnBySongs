//
//  SplashVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        checkLoginState()
    }

    func checkLoginState() {
        if UserDefaults.standard.string(forKey: "LoginState") == "logined" {
            userLogin() { success in
                if (success) {
                    self.goToMainView()
                } else {
                    self.popupAlert(title: nil, message: kLOGIN_FAILED)
                }
            }
        } else {
            delay(3.00) {
                self.goToLoginView()
            }
        }
    }
    
    func goToMainView() {
        getVideosFromDB() { success in
            if (success) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
                
                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                leftViewController.mainViewController = nvc
                
                let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                slideMenuController.delegate = mainViewController
                self.present(slideMenuController, animated: true, completion: nil)
            } else {
                self.popupAlert(title: nil, message: kGET_VIDEO_FAILED)
            }
        }
    }
    
    func goToLoginView() {
        let loginView =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginView, animated: true, completion: nil)
    }
}
