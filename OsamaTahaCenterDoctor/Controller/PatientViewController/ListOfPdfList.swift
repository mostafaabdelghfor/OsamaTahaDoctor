//
//  RepostVisitViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/13/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ListOfPdfList: UIViewController ,UITableViewDelegate,UITableViewDataSource {
  

    @IBOutlet weak var tableViewPDFList: UITableView!
    var destinationURLForFile:URL?
    var pdfListItem = [pdfList]()
    var visitID = ""
    var pdfURL = ""
//    @IBOutlet weak var visitWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewPDFList.delegate = self
        tableViewPDFList.dataSource = self
   
        if let getRequest_handler_key = helper.getRequest_handler_key(){
            API.getPatientVistaEMR(request_handler_key: getRequest_handler_key, visitId: visitID){ (satutsCode:Int ,pdfList:[pdfList]?)in
//                self.activityProgress.isHidden  = true
                
//                self.createAlert(title: self.visitID, message: self.visitID)
                
                
                
                self.pdfListItem = pdfList!
                
                print(self.pdfListItem.isEmpty)
                if (self.pdfListItem.isEmpty == true)
                {
                    
                    self.createAlert(title: "patient_visit_emr_documents", message: "empty")
                }

                self.tableViewPDFList.reloadData()
                
            }
        }
        else{
            
            print("first login")
            //            performSegue(withIdentifier: "FROMONBOARDINGTOLOGIN", sender: self)
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            
            self.present(vc!, animated: true, completion: nil)
            
            
        }
        
        



        
    }
 
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  pdfListItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PDFListCell", for: indexPath) as? PDFListCell
        cell?.title.text = pdfListItem[indexPath.row].title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
      
        
        self.pdfURL = pdfListItem[indexPath.row].url

     
        
        performSegue(withIdentifier: "showPdf" , sender: nil )
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showPdf") {
            // initialize new view controller and cast it as your view controller
            let DisplayPdfViewController = segue.destination as! DisplayPdfViewController
            
            DisplayPdfViewController.pdfURL = pdfURL
            DisplayPdfViewController.visitId = self.visitID
        
        }
     
        
        
        
        
        
    }
    
    
}
