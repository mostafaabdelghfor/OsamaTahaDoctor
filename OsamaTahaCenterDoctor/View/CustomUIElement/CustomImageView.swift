
//
//  CustomImageView.swift
//  TopServices1
//
//  Created by mac on 10/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
@IBDesignable

class CustomImageView: UIImageView {
    
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Sets the color of the border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

