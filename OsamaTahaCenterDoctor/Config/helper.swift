//
//  helper.swift
//  TopServices1
//
//  Created by Alchemist on 10/14/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class helper: NSObject {
    //restarting App
    @objc class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController
        if getCookies() == nil {
            // go to auth screen
            vc = sb.instantiateInitialViewController()! // to the initial VC
        } else {
            // go to main screen
            
            vc = sb.instantiateViewController(withIdentifier: "TabBarViewController")
        }
        
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
   
    
    
    
    @objc class func saveRequest_handler_key(token: String) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.setValue(token, forKey: "request_handler_key")
        def.synchronize()
        //        restartApp()v
        
        
    }
    
    @objc class func saveDoctorID(token: String) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.setValue(token, forKey: "saveDoctorID")
        def.synchronize()
        //        restartApp()v
        
        
    }
    
    @objc class func saveDeviceToken(token: String) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.setValue(token, forKey: "saveDeviceToken")
        def.synchronize()
        //        restartApp()v
        
        
    }
    @objc class func getDeviceToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "saveDeviceToken") as? String
    }
    
    @objc class func saveOdooId(token: Int) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.setValue(token, forKey: "saveOdooId")
        def.synchronize()
        //        restartApp()v
        
        
    }
    @objc class func getOdooId() -> Int {
        let def = UserDefaults.standard
        return (def.object(forKey: "saveOdooId") as? Int)!
    }
    
   
    
    
    
    @objc class func getRequest_handler_key() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "request_handler_key") as? String
    }
    
    @objc class func getdoctorID() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "saveDoctorID") as? String
    }
  
    
    
    
    @objc class func getLastName() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "lastName") as? String
    }
    
    @objc class func savePhone(token: String) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.setValue(token, forKey: "phone")
        def.synchronize()
        //        restartApp()v
        
    }
    
    // getting data from UserDefaults
    @objc class func getPhone() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "phone") as? String
    }
    
    
    //    @objc class func saveloginFlag(token: String) {
    //        let def = UserDefaults.standard
    //        def.setValue(token, forKey: "login-flag")
    //        def.synchronize()
    //        restartApp()
    //
    //    }
    
    
    
    
    
    
    // getting data from UserDefaults
    @objc class func getCookies() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "Set-cookyies") as? String
    }
    
    //    @objc class func getLoginFlag() -> String? {
    //        let def = UserDefaults.standard
    //        return def.object(forKey: "login-flag") as? String
    //    }
    //
    
    
    
    
    
    @objc class func removeCookies(token: String) {
        // save api token to UserDefaults
        let def = UserDefaults.standard
        def.removeObject(forKey: "Set-cookyies")
        def.synchronize()
        //        restartApp()
        
    }
    
    @objc class func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //CREATING ON BUTTON
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        
        // self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}




