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

//ScreenSize Bound
let kScreenSize: CGSize = UIScreen.main.bounds.size

//let slideMenuVC = ExSlideMenuController(mainViewController:naviMain, leftMenuViewController: kLeftMenuVC!)
