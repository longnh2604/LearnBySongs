//
//  SplashVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import RevealingSplashView

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "myLogo")!, iconInitialSize: CGSize(width: 100, height: 100), backgroundColor: UIColor.init(red: 255/255.0, green: 107/255.0, blue: 107/255.0, alpha: 1))
        revealingSplashView.useCustomIconColor = false
        revealingSplashView.iconColor = UIColor.red
        revealingSplashView.animationType = SplashAnimationType.popAndZoomOut
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
            self.checkLoginState()
        }
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
            self.goToLoginView()
        }
    }
    
    //go straight Main View
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
