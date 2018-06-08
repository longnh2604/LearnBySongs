//
//  KaraokeLyricParser.swift
//  LearnBySongs
//
//  Created by Long on 2018/06/08.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import Foundation

protocol KaraokeLyricParser {
    //var lyricContent:String? { get set }
    func lyricFromLRCString(lrcStr:String) -> KaraokeLyric
}


extension KaraokeLyricParser {
    func lyricFromLocalPathFileName(lrcFileName:String) -> KaraokeLyric? {
        
        guard let filePath = Bundle.main.path(forResource: lrcFileName, ofType: "lrc") else { return nil }
        
        if let lyricContent = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8) {
            return self.lyricFromLRCString(lrcStr: lyricContent)
        }
        
        return nil
    }
    
    func timeStr2Float(strTime: String) -> CGFloat {
        var result:CGFloat = 0
        
        let timeParts = strTime.components(separatedBy: ":")
        if timeParts.count > 1 {
            let min = Double(timeParts[0]) ?? 0
            let sec = Double(timeParts[1]) ?? 0
            result = CGFloat(min * 60 + sec)
        }
        
        return result
    }
}



struct BasicKaraokeLyricParser:KaraokeLyricParser {
    //var lyricContent:String?
    
    func lyricFromLRCString(lrcStr: String) -> KaraokeLyric {
        
        let lyricRows = lrcStr.components(separatedBy: NSCharacterSet.newlines)
        var lyricDict:Dictionary<CGFloat,String> = Dictionary<CGFloat,String>()
        
        
        var title:String = "", artist = "", album = "", by = ""
        
        for row in lyricRows {
            
            if row.hasPrefix("[") {
                
                if row.hasPrefix("[ti:") || row.hasPrefix("[ar:") || row.hasPrefix("[al:") || row.hasPrefix("[by:") {
                    
                    let startIndex = row.index(row.startIndex, offsetBy: 5)
                    let endIndex = row.index(row.endIndex, offsetBy: -2)
                    let startIndex1 = row.index(row.startIndex, offsetBy: 1)
                    let startIndex2 = row.index(row.startIndex, offsetBy: 2)
                    
                    let range1 = startIndex...endIndex
                    let text = String(row[range1])
                    
                    let range2 = startIndex1...startIndex2
                    switch String(row[range2]) {
                    case "ti":
                        title       = text
                    case "ar":
                        artist      = text
                    case "al":
                        album        = text
                    case "by":
                        by        = text
                    default:
                        print("Unknow text")
                    }
                    
                } else {
                    let textParts = row.components(separatedBy: NSCharacterSet(charactersIn: "[]") as CharacterSet)
                    let lyricText = textParts[2];
                    let keyTime = self.timeStr2Float(strTime: textParts[1])
                    lyricDict[keyTime] = lyricText
                }
            }
        }
        
        var lyric = KaraokeLyric(title: title, singer: artist, composer: by, album: album)
        lyric.content = lyricDict
        return lyric
        
    }
}
