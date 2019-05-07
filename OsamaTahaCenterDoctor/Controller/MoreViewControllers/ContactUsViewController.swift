//
//  ContactUsViewController.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/12/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import Firebase

//import FirebaseFirestore
class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var website: UILabel!
    
    
    @IBOutlet weak var findUsFirsAddress: UILabel!
    
    @IBOutlet weak var findUsFirstAddressName: UILabel!
    
    @IBOutlet weak var findUsFirstPhone: UILabel!
    
    @IBOutlet weak var findUssecondAddress: UILabel!
    
    
    @IBOutlet weak var findUsSecondAddressName: UILabel!
    
    @IBOutlet weak var findUssecondPhone: UILabel!
    override func
        viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Send to Us"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
//        
        let db = Firestore.firestore()
        
        
        //        let docRef = db.collection("DrOsama").document("BasicInformation")
        
        db.collection("DrOsama").document("ContactInfo").getDocument { (document, error) in
            if let document = document, document.exists {
                //access data here
                self.email.text = document.get("email") as? String
                self.website.text = document.get("website") as? String
                
                let findUS = document.get("findUs") as! Array<Dictionary<String, Any>>
                
                self.findUsFirsAddress.text = findUS[0]["address"] as? String
                self.findUsFirstAddressName.text = findUS[0]["name"] as? String
                self.findUsFirstPhone.text = findUS[0]["phone"] as? String
                
                
                
                self.findUssecondAddress.text = findUS[1]["address"] as? String
                self.findUsSecondAddressName.text = findUS[1]["name"] as? String
                self.findUssecondPhone.text = findUS[1]["phone"] as? String
                
            } else {
                print("Document does not exist")
            }
        }
        
        
        
    }
    
    
    
    
}

