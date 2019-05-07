//
//  MyProfileViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/6/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    

    @IBOutlet weak var MyProfileServicesViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        MyProfileServicesViewController.dataSource = self
        MyProfileServicesViewController.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileCellServices", for: indexPath) as? MyProfileCellServices
        
        return cell!
        
    }
  

}
