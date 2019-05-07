//
//  MedicalRecordsViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/5/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class MedicalRecordsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var mr_no = ""
    var  medicalVisits = [patientVisitis]()
    @IBOutlet weak var medicalRecordTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("i am in medcal and tis \(mr_no)")
        
      medicalRecordTableView.dataSource = self
        medicalRecordTableView.delegate = self

        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Medical Records"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        
        if let getRequest_handler_key = helper.getRequest_handler_key(){
            API.getPatientVista(request_handler_key: getRequest_handler_key, mr_no: mr_no){ (satutsCode:Int ,patientVisits:[patientVisitis]?)in
                //                self.activityProgress.isHidden  = true
                
                if (satutsCode == 0)
                {
                    self.createAlert(title: "No Internet Connection", message: "Error")
                }
                    
                else{
                    if (satutsCode == 200)
                    {
                        
                        print("Hello get patient details")
                        
                        
                        if let ConstantpatientVisits = patientVisits
                        {
                            self.medicalVisits = ConstantpatientVisits
                            self.medicalRecordTableView.reloadData()
                        }
                    }
                    if (satutsCode == 400)
                    {
                        print("seesion is experied")
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                        
                        self.present(vc!, animated: true, completion: nil)
                        
                        
                    }
                }
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
        return medicalVisits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: "MedicalRecordsCell", for: indexPath) as? MedicalRecordsCell
        
        cell?.doctorName.text = medicalVisits[indexPath.row].doctorNAme
        cell?.dateVisitTime.text = medicalVisits[indexPath.row].dateVistTime
        cell?.visitId.text = medicalVisits[indexPath.row].visitId
        
        cell?.checkVisitPdf.accessibilityHint = String (medicalVisits[indexPath.row].visitId)
        cell?.checkVisitPdf.addTarget(self, action: #selector(addFavorite), for: UIControl.Event.touchUpInside)
        return cell!
        
        return cell!
    
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
        
        
    }
    var visitId = ""
    @IBAction func addFavorite(sender: UIButton) -> Void {
        
        
        let vistit  = sender.accessibilityHint
        
      
        visitId = vistit!
        performSegue(withIdentifier: "visitIdPdf", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "visitIdPdf") {
            // initialize new view controller and cast it as your view controller
            let RepostVisitViewController = segue.destination as! ListOfPdfList
            
            RepostVisitViewController.visitID = visitId
            
            print("i go to medcal \(mr_no)")
        }
        
    }

    

}
