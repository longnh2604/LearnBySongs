//
//  AudioPlayer.swift
//  LearnBySongs
//
//  Created by Long on 2018/06/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import Foundation
import MediaPlayer

class AudioPlayer {
    
    var avPlayer: AVPlayer!
    
    init() {
        avPlayer = AVPlayer()
    }
    
    func playStream(fileURL: URL) {
        avPlayer = AVPlayer(url: fileURL)
        avPlayer.play()
        print("Playing Stream")
    }
    
    func playAudio() {
        
        if avPlayer.rate == 0 && avPlayer.error == nil {
            avPlayer.play()
        }
        
    }
    
    func pauseAudio() {
        
        if avPlayer.rate > 0 && avPlayer.error == nil {
            avPlayer.pause()
        }
        
    }
    
}
