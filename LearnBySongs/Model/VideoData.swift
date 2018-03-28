//
//  VideoData.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation
import RealmSwift

class VideoData: Object {
    @objc dynamic var videoID: Int = 0
    @objc dynamic var videoTitle: String = ""
    @objc dynamic var videoAuthor: String = ""
    @objc dynamic var videoURL: String = ""
    @objc dynamic var videoLyric : String = ""
    @objc dynamic var videoThumb : String = ""
    @objc dynamic var videoWords : String = ""
//    var videoWords = List<String>()
}
