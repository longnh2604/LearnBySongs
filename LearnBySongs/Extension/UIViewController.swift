//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
extension UIViewController {
    
    func addMenuBarButton() {
        self.addLeftBarButtonWithImage(UIImage(named: "sideMenuIcon")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func addRightBarButton() {
        self.addRigtBarButtonWithImage(UIImage(named: "addImageIcon")!, action: #selector(openPhotoVC))
//        self.addRightBarButtonWithImage(UIImage(named: "addImageIcon")!)
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    public func addLeftBarButtonWithImage(_ buttonImage: UIImage, action:Selector?) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action:action)
        navigationItem.leftBarButtonItem = leftButton;
    }
    public func addRigtBarButtonWithImage(_ buttonImage: UIImage, action:Selector?) {
        let button: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action:action)
        navigationItem.rightBarButtonItem = button;
    }
    
    public func addRigtBarTwoButtonWithImage(button1 : UIBarButtonItem, button2 : UIBarButtonItem) {
        navigationItem.rightBarButtonItems = [button1 , button2]
    }
    
    public func addRigtBarButtonWithImage(button1 : UIBarButtonItem) {
        navigationItem.rightBarButtonItem = button1
    }
    
    func dismissVC(sender: AnyObject){
        self.dismiss(animated: true)
    }
    
    @objc func openPhotoVC() {
        
    }
}
