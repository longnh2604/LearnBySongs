//
//  UserManagement.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

//MARK: - Firebase Authentication
/***************************************************************/

func userLogin(completion: @escaping (Bool) -> ()) {
    let cusEmail = "longnh264@gmail.com"
    let cusPassword = "123456"
    Auth.auth().signIn(withEmail: cusEmail , password: cusPassword) { (user, error) in
        if error != nil {
            print(error!)
            completion(false)
        } else {
            print("Firebase Auth passed!")
            userDefaults.set(cusEmail, forKey: "email")
            userDefaults.set(cusPassword, forKey: "password")
            userDefaults.synchronize()
            
            findUser() { success in
                if (success) {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}

func getAppNotify() {
//    queryRef.child("appnotify").observeSingleEvent(of: .value, with: { (snapshot) in
//        for snap in snapshot.children.allObjects as! [DataSnapshot] {
//            guard let dictionary = snap.value as? [String: AnyObject] else {
//                return
//            }
//            print(dictionary)
//            let notiID = dictionary["notiID"] as? Int
//            let version = dictionary["version"] as? String
//            let news = dictionary["news"] as? String
//            let content = dictionary["content"] as? String
//
//            let newNoti = AppNotify()
//            newNoti.notiID = notiID!
//            newNoti.notiVersion = version!
//            newNoti.notiNews = news!
//            newNoti.notiContent = content!
//
//            RealmServices.shared.create(newNoti)
//        }
//    })
}

//MARK: - Get User Info
/***************************************************************/

func findUser(completion:@escaping (Bool) -> ()) {
    let userEmail = userDefaults.string(forKey: "email")
    
    queryRef.child("users").queryOrdered(byChild: "email").queryEqual(toValue: userEmail).observeSingleEvent(of: .value, with: { (snapshot) in
        guard snapshot.value is NSNull else {
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else {
                    completion(false)
                    return
                }
                print(dictionary)
                let userID = dictionary["userID"] as? Int
                let username = dictionary["username"] as? String
                let email = dictionary["email"] as? String
                let password = dictionary["password"] as? String
                let type = dictionary["type"] as? Int
                let image = dictionary["image"] as? String
                
                let newUser = UserData()
                newUser.userID = userID!
                newUser.userName = username!
                newUser.userEmail = email!
                newUser.userPassword = password!
                newUser.userType = type!
                newUser.userImage = image!
                
                RealmServices.shared.create(newUser)
            }
            completion(true)
            return
        }
    }) { (error) in
        completion(false)
        print("Failed to get snapshot", error.localizedDescription)
    }
}

//MARK: - Get Account Type
/***************************************************************/

func getUserType(type:Int)->String {
    var userType = ""
    if (type == 1) {
        userType = "Normal Account"
    } else if (type == 2) {
        userType = "Premium Account"
    } else {
        userType = "Unknown Account"
    }
    return userType
}
