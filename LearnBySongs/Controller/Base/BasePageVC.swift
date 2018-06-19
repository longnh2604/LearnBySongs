//
//  BasePageVC.swift
//  NewApp
//
//  Created by Long on 2018/03/12.
//  Copyright © 2018 Oluxe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class BasePageVC: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuBarButton()
        removeTapRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

//*****************************************************************
// MARK: - Remove Tap to Slide Page
//*****************************************************************

extension UIPageViewController {
    func removeTapRecognizer() {
        let gestureRecognizers = self.gestureRecognizers
        
        var tapGesture: UIGestureRecognizer?
        gestureRecognizers.forEach { recognizer in
            if recognizer.isKind(of: UITapGestureRecognizer.self) {
                tapGesture = recognizer
            }
        }
        if let tapGesture = tapGesture {
            self.view.removeGestureRecognizer(tapGesture)
        }
    }
}

//*****************************************************************
// MARK: - SlideMenuController Delegate
//*****************************************************************

extension BasePageVC : SlideMenuControllerDelegate {
    
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

