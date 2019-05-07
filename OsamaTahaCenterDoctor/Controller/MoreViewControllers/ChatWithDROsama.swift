//
//  ChatWithDROsama.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/13/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class ChatWithDROsama: UIViewController  ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var chatTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Chat with Dr. Osama"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChatCell
        
        if indexPath.row % 2 == 0
        {
            
//            cell?.backGround.isHidden = false
            
        }
        else
        {
            
//            cell?.SendermessageBackGroundView.isHidden = false
            
        }
        
        
//        cell?.SendermessageBackGroundView.layer.cornerRadius = 15
//        cell?.SendermessageBackGroundView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
//        cell?.backGround.layer.cornerRadius = 15
//        
//        cell?.backGround.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner, .layerMaxXMaxYCorner]
//        
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        chatTableView.estimatedRowHeight = 600
        chatTableView.rowHeight =  UITableView.automaticDimension
        
    }
    
    
    
}

