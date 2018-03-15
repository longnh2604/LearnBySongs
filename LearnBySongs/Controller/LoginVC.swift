//
//  LoginVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToMainView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController
        self.present(slideMenuController, animated: true, completion: nil)
    }
    
    @IBAction func onNormalLogin(_ sender: UIButton) {
        userLogin() { success in
            if (success) {
                UserDefaults.standard.set("logined", forKey: "LoginState")
                UserDefaults.standard.synchronize()
                self.goToMainView()
            } else {
                self.popupAlert(title: nil, message: kLOGIN_FAILED)
                return
            }
        }
    }
    
    @IBAction func onFacebookLogin(_ sender: UIButton) {
    
    }
    
    @IBAction func onGmailLogin(_ sender: UIButton) {
        
    }
}
