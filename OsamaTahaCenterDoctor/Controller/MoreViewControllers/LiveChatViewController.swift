//
//  LIveChatViewController.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/13/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import Firebase
class LiveChatViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    var liveChatItem = [LiveChatModel]()
    
    @IBOutlet weak var LiveChatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        LiveChatTableView.delegate = self
        LiveChatTableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Chat with Dr. Osama"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
      let db =  Firestore.firestore()
        db.collection("GroupsLiveChat").whereField("allowedDoctors", arrayContains: helper.getdoctorID()) .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                

                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(err!)")
                    return
                }
                self.liveChatItem = []
                
                for document in querySnapshot!.documents {
                    
                    let liveChat1 =  LiveChatModel(title: document.get("title") as! String, message: document.get("message") as! String, groupId: document.documentID)
                    
                    
                    
                    self.liveChatItem.append(liveChat1)
                    
                    self.LiveChatTableView.reloadData()
                    
                }
                
                
            }
        
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveChatItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveChatCell", for: indexPath) as? LiveChatCell
        
        cell?.title.text = liveChatItem[indexPath.row].title
        cell?.message.text = liveChatItem[indexPath.row].message
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
       
            
            let vc = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "PatientInboxGroupViewController") as? PatientInboxGroupViewController
            self.navigationController?.pushViewController(vc!, animated: true)
          
   
        vc?.groupId = liveChatItem[indexPath.row].groupId
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        LiveChatTableView.estimatedRowHeight = 600
        LiveChatTableView.rowHeight =  UITableView.automaticDimension
        
    }
    
    
    
}

