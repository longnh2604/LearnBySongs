//
//  UserData.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation
import RealmSwift

class UserData: Object {
    @objc dynamic var userID: Int = 0
    @objc dynamic var userName: String = ""
    @objc dynamic var userEmail: String = ""
    @objc dynamic var userImage : String = ""
    @objc dynamic var userPassword : String = ""
    @objc dynamic var userType : Int = 0
}
