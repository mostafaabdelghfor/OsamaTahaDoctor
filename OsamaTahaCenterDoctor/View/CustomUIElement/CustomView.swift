//
//  CustomView.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/3/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class CustomView: UIView {

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
