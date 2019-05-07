//
//  ChangeLanguageViewController.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/12/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class ChangeLanguageViewController: UIViewController {
    
    
    @IBOutlet weak var arabicView: CustomView!
    @IBOutlet weak var englishView: CustomView!
    @IBOutlet weak var iconEngliahShadow: CustomView!
    
    @IBOutlet weak var arabicChangeIcon: UIImageView!
    @IBOutlet weak var EnglishChangeIcon: UIImageView!
    @IBOutlet weak var changeIconShadowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //        changeIconShadowView.layer.cornerRadius = 3
        //        changeIconShadowView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        //        changeIconShadowView.layer.shadowOffset = CGSize(width: 1, height: 2)
        //        changeIconShadowView.layer.shadowRadius = 1
        //        changeIconShadowView.layer.shadowOpacity = 0.20
        //
        //        iconEngliahShadow.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        //        iconEngliahShadow.layer.shadowOffset = CGSize(width: 1, height: 2)
        //        iconEngliahShadow.layer.shadowRadius = 1
        //        iconEngliahShadow.layer.shadowOpacity = 0.20
        
    }
    //
    //    override func viewWillAppear(_ animated: Bool) {
    ////
    //        self.modalPresentationStyle = .overCurrentContext
    ////        view.backgroundColor = UIColor.clear
    //        view.isOpaque = false
    //
    ////        self.hidesBottomBarWhenPushed = true
    //
    //
    //
    //    }
    
    
    
    @IBAction func ButtonEnglishClicked(_ sender: Any) {
        
        englishView.borderColor = #colorLiteral(red: 0.1215686275, green: 0.737254902, blue: 0.8470588235, alpha: 1)
        arabicView.borderColor = #colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.6823529412, alpha: 1)
        
        EnglishChangeIcon.image = UIImage(named: "blueLanguagechangeIcon")
        
        arabicChangeIcon.image = UIImage(named: "greyLabguageChangeIcon")
        
    }
    
    @IBAction func buttonArabicClicked(_ sender: Any) {
        
        englishView.borderColor = #colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.6823529412, alpha: 1)
        arabicView.borderColor = #colorLiteral(red: 0.1215686275, green: 0.737254902, blue: 0.8470588235, alpha: 1)
        
        EnglishChangeIcon.image = UIImage(named: "greyLabguageChangeIcon")
        
        arabicChangeIcon.image = UIImage(named: "blueLanguagechangeIcon")
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
        
        let MoreViewController = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "MoreViewController") as? MoreViewController
        
        
        MoreViewController?.tabBarController?.tabBar.isHidden = false
        
        
    }
    
    
    
}

