//
//  VideoManagement.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

//MARK: - Get Videos
/***************************************************************/

func getVideosFromDB(completionHandler:@escaping (Bool) -> ()) {
    queryRef.child("videos").observeSingleEvent(of: .value, with: { (snapshot) in
        for snap in snapshot.children.allObjects as! [DataSnapshot] {
            guard let dictionary = snap.value as? [String: AnyObject] else {
                completionHandler(false)
                return
            }
            print(dictionary)
            let videoID = dictionary["videoID"] as? Int
            let title = dictionary["title"] as? String
            let url = dictionary["url"] as? String
            let lyric = dictionary["lyric"] as? String
            let thumb = dictionary["thumb"] as? String
            let author = dictionary["author"] as? String
            let words = dictionary["words"] as? String
            let newVideo = VideoData()
            
//            if dictionary["words"] != nil {
//                if let words = dictionary["words"] as? [String]{
//                    for word in words {
//                        newVideo.videoWords.append(word)
//                    }
//                }
//            }
            newVideo.videoID = videoID!
            newVideo.videoTitle = title!
            newVideo.videoURL = url!
            newVideo.videoLyric = lyric!
            newVideo.videoThumb = thumb!
            newVideo.videoAuthor = author!
            newVideo.videoWords = words!

            RealmServices.shared.create(newVideo)
        }
        completionHandler(true)
    })
}

