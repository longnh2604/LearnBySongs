//
//  VideoDetailVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/15.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit
import RealmSwift

class VideoDetailVC: UIViewController {

    var cellIndex : Int?
    @IBOutlet weak var lblTitle: UILabel!
    var videos: Results<VideoData>!
    var videoPlayer:AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cellIndex = 1
//        
//        let realm = RealmServices.shared.realm
//        videos = realm.objects(VideoData.self)
//        
//        lblTitle.text = videos[cellIndex!].videoTitle
    }

    @IBAction func onPlay(_ sender: UIButton) {
        
        // Video Player
        let videoURL = NSURL(string: videos[cellIndex!].videoURL)
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // Add subtitles
        let subtitleURL = NSURL(string: videos[cellIndex!].videoLyric)! as URL
        playerViewController.addSubtitles().open(file: subtitleURL)
        playerViewController.addSubtitles().open(file: subtitleURL, encoding: .utf8)
        // Text Properties
        playerViewController.subtitleLabel?.textColor = UIColor.red
        
        // Play
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func subtitleParser() {
        
        // Subtitle file
        let subtitleFile = Bundle.main.path(forResource: videos[cellIndex!].videoLyric, ofType: "srt")
        let subtitleURL = URL(fileURLWithPath: subtitleFile!)
        
        // Subtitle parser
        let parser = Subtitles(file: subtitleURL, encoding: .utf8)
        
        // Do something with result
        let subtitles = parser.searchSubtitles(at: 2.0) // Search subtitle at 2.0 seconds
        print("in subtitle = %@",subtitles!)
    }
    
}
