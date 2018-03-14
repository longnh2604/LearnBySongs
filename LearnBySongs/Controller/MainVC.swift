//
//  MainVC.swift
//  LearnBySongs
//
//  Created by Long on 2018/03/14.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MainVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuVC.delegate = self
    }

}

//MARK: - SlideMenuController Delegate
/***************************************************************/
extension MainVC : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
        
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
        
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
        
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
        
    }
    
    func rightWillOpen() {
        
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
        
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
        
    }
}

//MARK: - UIImageView
/***************************************************************/
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    func roundImage(with Image: UIImageView) {
        Image.contentMode = UIViewContentMode.scaleAspectFill
        Image.layer.borderWidth = 1.0
        Image.layer.masksToBounds = false
        Image.layer.borderColor = UIColor.white.cgColor
        Image.layer.cornerRadius = (Image.frame.width)/2
        Image.clipsToBounds = true
    }
}
