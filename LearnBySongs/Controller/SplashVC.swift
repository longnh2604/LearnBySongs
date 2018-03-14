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
            goToMainView()
        } else {
            delay(3.00) {
                self.goToLoginView()
            }
        }
    }
    
    func goToMainView() {
        self.present(slideMenuVC, animated: true, completion: nil)
    }
    
    func goToLoginView() {
        let loginView =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginView, animated: true, completion: nil)
    }
}
