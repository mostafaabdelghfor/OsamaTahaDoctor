//
//  MyAppointmentsViewController.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/6/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class MyAppointmentsViewController: UIViewController  ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var myAppointmentsViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        myAppointmentsViewController.dataSource = self
        myAppointmentsViewController.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAppoinmentCell", for: indexPath) as? MyAppoinmentCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
        
        
    }
    
    
}

