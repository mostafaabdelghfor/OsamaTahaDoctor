//
//  PatientInboxGroupViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/26/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import Firebase
class PatientInboxGroupViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var groupId = ""
    var patientInboxItem = [PatientInboxModel]()
    @IBOutlet weak var PatientInboxTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PatientInboxTableView.delegate = self
        PatientInboxTableView.dataSource = self
        
        
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Patient Chats"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let db = Firestore.firestore()
        
        db.collection(groupId)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    for doument in (querySnapshot?.documents)!
                    {
                        
                        print(doument.documentID)
                        
                        
                        let patientInbox =  PatientInboxModel(Lastmessage: doument.get("lastMessage") as! String , PatientName: doument.get("patientName") as! String, LastMessageDate: doument.get("lastMessageDate") as! Date, PatientId: doument.get("patientId") as! String)
                        
                        
                        
                        self.patientInboxItem.append(patientInbox)
                        
                        
                        self.PatientInboxTableView.reloadData()
                        
                    }
                    
                    
                }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientInboxItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell", for: indexPath) as? inboxCell
        
        cell?.lastMessage.text = patientInboxItem[indexPath.row].Lastmessage
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        dateFormatter.timeZone = TimeZone(identifier: "UTC +2")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let convertedDate  = dateFormatter.string(from: patientInboxItem[indexPath.row].LastMessageDate)
        
        cell?.LastMessageDate.text = convertedDate
        cell?.PatientNAme.text = patientInboxItem[indexPath.row].PatientName
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        PatientName   =   patientInboxItem[indexPath.row].PatientName
        mr_no   =   patientInboxItem[indexPath.row].PatientId
        
        //        performSegue(withIdentifier: "sendMessage", sender: self)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "More", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChatwithPatientInGroup") as! ChatwithPatientInGroup
         vc.patientId  =  patientInboxItem[indexPath.row].PatientId
         vc.groupId = groupId

        self.show(vc, sender: self)
    }
    var   mr_no = ""
    var   PatientName = ""
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    // MARK: - Table view data source
    
    
}
