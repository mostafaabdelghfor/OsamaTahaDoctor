//
//  LoginViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/3/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var activityProgress: UIActivityIndicatorView!
    @IBOutlet weak var mobileUserPassword: UITextField!
    @IBOutlet weak var mobileUserID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Services.setTextFieldIcon(UIImage(named: "Profile.png")!, mobileUserID)
        Services.setTextFieldIcon(UIImage(named: "002-password.png")!, mobileUserPassword)
        self.navigationController?.isNavigationBarHidden = true
        
        activityProgress.isHidden = true
        
        
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func LoginClicked(_ sender: UIButton) {
        
//                            self.performSegue(withIdentifier: "FROMLOGINTOHOME", sender: self)

        
        guard let mobileUserID = mobileUserID.text, !mobileUserID.isEmpty else {
            
            self.createAlert(title: "error", message: "Plz write Your Id")
            
            return }
        guard let mobileUserPassword = mobileUserPassword.text, !mobileUserPassword.isEmpty else {
            
            self.createAlert(title: "error", message: "Plz write Your Password")

            return }
        activityProgress.isHidden = false

        API.Login(mobile_user_id: mobileUserID, mobile_user_password: mobileUserPassword){  (error:Bool,satutsCode:Int) in
            
            self.activityProgress.isHidden = true
            
            if error{
                
                self.createAlert(title: "Error", message: "No Internet Connection")
                
                
            }
                
            else{
                
                if (satutsCode == 401)
                {
                    
                    self.createAlert(title: "Error", message: "User Id Or Password Is Wrong")
                    
                }
                if (satutsCode == 200){
                    
                    self.performSegue(withIdentifier: "FROMLOGINTOHOME", sender: self)
                    
                    
                }
            }
            
        }
    }

  

}
