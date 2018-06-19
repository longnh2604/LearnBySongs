//
//  LoginVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import TKSubmitTransition

class LoginVC: UIViewController {

    //IBOutlet
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: TKTransitionSubmitButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToMainView() {
        getVideosFromDB() { success in
            if (success) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainPageVC") as! MainPageVC
                let leftViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
                
                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                leftViewController.mainViewController = nvc
                
                let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
                slideMenuController.delegate = mainViewController
                
                self.btnLogin.startFinishAnimation(1, completion: {
                    self.present(slideMenuController, animated: true, completion: nil)
                })
                
            } else {
                self.popupAlert(title: nil, message: kGET_VIDEO_FAILED)
            }
        }
    }
    
    //*****************************************************************
    // MARK: - Actions
    //*****************************************************************
    
    @IBAction func onNormalLogin(_ sender: UIButton) {
        btnLogin.startLoadingAnimation()
        userLogin() { success in
            if (success) {
                UserDefaults.standard.set("logined", forKey: "LoginState")
                UserDefaults.standard.synchronize()
                self.goToMainView()
            } else {
                self.popupAlert(title: nil, message: kLOGIN_FAILED)
            }
        }
    }
}
