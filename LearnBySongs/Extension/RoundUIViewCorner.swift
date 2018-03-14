//
//  RoundUIViewCorner.swift
//  ABCarte2
//
//  Created by Long Nguyen on 2017/12/06.
//  Copyright © 2017 longnh. All rights reserved.
//

import UIKit
@IBDesignable

class RoundUIViewCorner: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
