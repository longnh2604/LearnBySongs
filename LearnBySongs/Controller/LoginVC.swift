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

        // Do any additional setup after loading the view.
    }
    
    func goToMainView() {
        self.present(slideMenuVC, animated: true, completion: nil)
    }
    
    @IBAction func onNormalLogin(_ sender: UIButton) {
        userLogin() { success in
            if (success) {
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
