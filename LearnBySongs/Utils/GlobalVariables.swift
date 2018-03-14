//
//  GlobalVariables.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation

class GlobalVariables {
    public var cellIndex: Int = 0
    
    class var sharedManager: GlobalVariables {
        struct Static{
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
    
    func clearData() {
        
    }
}
