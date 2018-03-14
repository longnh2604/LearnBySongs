//
//  ViewController.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPlay(_ sender: UIButton) {
        // Video file
        let videoFile = Bundle.main.path(forResource: "trailer_720p", ofType: "mov")
        
        // Subtitle file
        let subtitleFile = Bundle.main.path(forResource: "trailer_720p", ofType: "srt")
        let subtitleURL = URL(fileURLWithPath: subtitleFile!)
        
        // Movie player
        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url: URL(fileURLWithPath: videoFile!))
        present(moviePlayer, animated: true, completion: nil)
        
        // Add subtitles
        moviePlayer.addSubtitles().open(file: subtitleURL)
        moviePlayer.addSubtitles().open(file: subtitleURL, encoding: .utf8)
        
        // Change text properties
        moviePlayer.subtitleLabel?.textColor = UIColor.red
        
        // Play
        moviePlayer.player?.play()
    }
    
    func subtitleParser() {
        
        // Subtitle file
        let subtitleFile = Bundle.main.path(forResource: "trailer_720p", ofType: "srt")
        let subtitleURL = URL(fileURLWithPath: subtitleFile!)
        
        // Subtitle parser
        let parser = Subtitles(file: subtitleURL, encoding: .utf8)
        
        // Do something with result
        let subtitles = parser.searchSubtitles(at: 2.0) // Search subtitle at 2.0 seconds
        print("in subtitle = %@",subtitles!)
    }
    
}

