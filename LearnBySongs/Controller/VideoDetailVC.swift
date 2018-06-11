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

    var cellIndex: Int?
    var lyric:KaraokeLyric?
    private var timingKeys:Array<CGFloat> = [CGFloat]()
    
    private var audioPlayer:AVAudioPlayer!
    private var playerTimer:Timer?
    
    @IBOutlet weak var sliderSong: UISlider!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imvVideoThumb: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lyricView: KaraokeLyricPlayerView!
    
    var videos: Results<VideoData>!
    var videoPlayer:AVPlayer!
    
    func handleInterruption(notification: NSNotification) {
        
        //guard let interruptionType = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? AVAudioSessionInterruptionType else { print("wrong type"); return }
        
        if notification.name != NSNotification.Name.AVAudioSessionInterruption
            || notification.userInfo == nil{
            return
        }
        
        var info = notification.userInfo!
        var intValue: UInt = 0
        (info[AVAudioSessionInterruptionTypeKey] as! NSValue).getValue(&intValue)
        if let interruptionType = AVAudioSessionInterruptionType(rawValue: intValue) {
            
            switch interruptionType {
                
            case .began:
                print("began")
                // player is paused and session is inactive. need to update UI)
                audioPlayer?.pause()
                print("audio paused")
                
            default:
                print("ended")
                /** /
                 if let option = notification.userInfo?[AVAudioSessionInterruptionOptionKey] as? AVAudioSessionInterruptionOptions where option == .ShouldResume {
                 // ok to resume playing, re activate session and resume playing
                 // need to update UI
                 player.play()
                 print("audio resumed")
                 }
                 / **/
                audioPlayer?.play()
                print("audio resumed")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let realm = RealmServices.shared.realm
        videos = realm.objects(VideoData.self)
        
        let lyricParser = BasicKaraokeLyricParser()
        lyric   = lyricParser.lyricFromLocalPathFileName(lrcFileName: "tri_ky")
        
        cellIndex = GlobalVariables.sharedManager.cellIndex
        
        lblTitle.text = videos[cellIndex!].videoTitle
        lblAuthor.text = videos[cellIndex!].videoAuthor
        lblDuration.text = "3 : 00"
        
        if let url = URL.init(string: videos[cellIndex!].videoThumb) {
            imvVideoThumb.downloadedFrom(url: url)
        }
        
        if let lyric = self.lyric , self.lyric?.content != nil {
            timingKeys = Array(lyric.content!.keys).sorted()
        }
        
        lyricView.dataSource = self
        lyricView.delegate = self
        
        let songURL = downloadFile(url: videos[cellIndex!].videoURL)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
            guard let player = audioPlayer else { return }
            audioPlayer.delegate = self
            player.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func downloadFile(url:String)->URL {
        var filePath: URL? = nil
        if let audioUrl = URL(string: url) {
            
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            print(destinationUrl)
            filePath = destinationUrl
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                print("The file already exists at path")
                
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
                    guard let location = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: location, to: destinationUrl)
                        print("File moved to documents folder")
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }).resume()
            }
            
        }
        return filePath!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        audioPlayer?.prepareToPlay()
        lyricView.prepareToPlay()
        
        self.title = self.lyric?.title
    }
    
    func stopAll() {
        playerTimer?.invalidate()
        audioPlayer?.stop()
        lyricView.stop()
    }
    
    func startTimer() {
        playerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStick(timer:)), userInfo: nil, repeats: true)
    }
    
    @objc func timerStick(timer:Timer) {
        
        if let audioPlayer = self.audioPlayer , audioPlayer.isPlaying {
            let value = audioPlayer.currentTime / audioPlayer.duration
            sliderSong.value = Float(value)
        }
        
    }
    
    @IBAction func onPlay(_ sender: UIButton) {
        audioPlayer?.play()
        lyricView.start()
        self.startTimer()
    }
}

extension VideoDetailVC: LyricPlayerViewDataSource {
    
    func timesForLyricPlayerView(playerView: KaraokeLyricPlayerView) -> Array<CGFloat> {
        return timingKeys
    }
    
    func lyricPlayerView(playerView: KaraokeLyricPlayerView, atIndex:NSInteger) -> KaraokeLyricLabel {
        
        let lyricLabel          = playerView.reuseLyricView()
        lyricLabel.textColor    = UIColor.white
        lyricLabel.fillTextColor = UIColor.blue
        lyricLabel.font         = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        
        let key = timingKeys[atIndex]
        
        lyricLabel.text = self.lyric?.content![key]
        return lyricLabel
    }
    
    func lyricPlayerView(playerView: KaraokeLyricPlayerView, allowLyricAnimationAtIndex: NSInteger) -> Bool {
        return true
    }
}

extension VideoDetailVC: LyricPlayerViewDelegate {
    func lyricPlayerViewDidStop(playerView: KaraokeLyricPlayerView) {
        playerTimer?.invalidate()
    }
    
    func lyricPlayerViewDidStart(playerView: KaraokeLyricPlayerView) {
//        self.toogleButton.setTitle("Pause", for: .normal)
//        self.toogleButton.tag = 1
    }
}

extension VideoDetailVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.stopAll()
    }
}

//Video
//    @IBAction func onPlay(_ sender: UIButton) {
//
//        // Video Player
//        let videoURL = NSURL(string: videos[cellIndex!].videoURL)
//        let player = AVPlayer(url: videoURL! as URL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//
//        // Add subtitles
//        let subtitleURL = NSURL(string: videos[cellIndex!].videoLyric)! as URL
//        playerViewController.addSubtitles().open(file: subtitleURL)
//        playerViewController.addSubtitles().open(file: subtitleURL, encoding: .utf8)
//        // Text Properties
//        playerViewController.subtitleLabel?.textColor = UIColor.red
//
//        // Play
//        self.present(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
//    }
//
//    func subtitleParser() {
//
//        // Subtitle file
//        let subtitleFile = Bundle.main.path(forResource: videos[cellIndex!].videoLyric, ofType: "srt")
//        let subtitleURL = URL(fileURLWithPath: subtitleFile!)
//
//        // Subtitle parser
//        let parser = Subtitles(file: subtitleURL, encoding: .utf8)
//
//        // Do something with result
//        let subtitles = parser.searchSubtitles(at: 2.0) // Search subtitle at 2.0 seconds
//        print("in subtitle = %@",subtitles!)
//    }
