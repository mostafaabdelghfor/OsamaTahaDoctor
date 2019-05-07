//
//  Services.swift
//  TopServices1
//
//  Created by mac on 9/30/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit
class Services {
    
    
    
    class  func setIconInVIEW(_ image : UIImage , _ view : UIView)  {
        
        let iconView = UIImageView(frame:
            CGRect(x: 0, y: 0, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 15, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        view.addSubview(iconContainerView)
    }
    
    class  func setTextFieldIcon(_ image : UIImage , _ textField : UITextField)  {
        let iconView = UIImageView(frame:
            CGRect(x: 20, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 30, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
    }
    
    class  func setTextFieldPadding(_ textField : UITextField)  {
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 0, y: 0, width: 13
                , height: 30))
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        
    }
    
    //    class  func setTextFieldIconForPickerViewTextField(_ image : UIImage , _ textField : CustomeFiled)  {
    //        let iconView = UIImageView(frame:
    //            CGRect(x: 0, y: 5, width: 20, height: 20))
    //        iconView.image = image
    //        let iconContainerView: UIView = UIView(frame:
    //            CGRect(x: 30, y: 0, width: 50, height: 30))
    //        iconContainerView.addSubview(iconView)
    //        textField.rightView = iconContainerView
    //        textField.rightViewMode = .always
    //
    //        let iconContainerView1: UIView = UIView(frame:
    //            CGRect(x: 30, y: 0, width: 50, height: 30))
    //        textField.leftView = iconContainerView1
    //        textField.leftViewMode = .always
    //
    //
    //    }
    
    
    
}


