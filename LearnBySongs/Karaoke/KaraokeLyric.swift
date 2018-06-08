//
//  KaraokeLyric.swift
//  LearnBySongs
//
//  Created by Long on 2018/06/08.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit

struct KaraokeLyric {
    var title:String
    var singer:String
    var composer:String
    var album:String
    var content:Dictionary<CGFloat,String>?
    
    init(title:String, singer:String, composer:String, album:String) {
        self.title      = title
        self.singer     = singer
        self.composer   = composer
        self.album      = album
    }
}
