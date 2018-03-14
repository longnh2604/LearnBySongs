//
//  Constant.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation
import Firebase

//Message
let kLOGIN_SUCCESS = "You are now logged in"
let kLOGIN_FAILED = "Failed to Login. Please check your Username and Password"
let kGET_VIDEO_FAILED = "Failed to get Video Data. Please check your Internet Connection"

//Database Ref
let queryRef = Database.database().reference()

//UserDefaults
let userDefaults = UserDefaults.standard

let kScreenSize: CGSize = UIScreen.main.bounds.size

//Main storyboard
let kMain_Storyboard = UIStoryboard(name: "Main", bundle: nil)
//Init SlideMenuVC
let mainVC = kMain_Storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainVC
let naviMain = UINavigationController(rootViewController: mainVC!)

let slideMenuVC = ExSlideMenuController(mainViewController:naviMain, leftMenuViewController: kLeftMenuVC!)
//Init LeftMenuVC
let kLeftMenuVC = kMain_Storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
