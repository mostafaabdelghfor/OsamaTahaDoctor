//
//  PatientViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/4/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
class PatientViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
  
    @IBOutlet weak var activityProgress: UIActivityIndicatorView!
    
    @IBOutlet weak var patientTableView: UITableView!
    
    var patientItem = [Patient]()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityProgress.isHidden  = false

        MRNOTextField.delegate = self
        firstNameTextField.delegate = self
        phoneTextField.delegate = self
        
        patientTableView.delegate = self
        patientTableView.dataSource = self
        patientTableView.cellLayoutMarginsFollowReadableWidth = true

        if let getRequest_handler_key = helper.getRequest_handler_key(){
            API.getPatient(request_handler_key: getRequest_handler_key){ (satutsCode:Int ,patient:[Patient]?)in
                self.activityProgress.isHidden  = true
                
                if (satutsCode == 0)
                {
                    self.createAlert(title: "No Internet Connection", message: "Error")
                }
                    
                else{
                    if (satutsCode == 200)
                    {
                        
                        print("Hello from services Page")
                        
                        
                        if let PatientServices = patient
                        {
                            self.patientItem = PatientServices
                            self.patientTableView.reloadData()
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as? PatientCell
        
        cell?.patientNameLabel.text = patientItem[indexPath.row].name
        
        cell?.viewProfile.accessibilityHint = String (indexPath.row)
        cell?.viewProfile.addTarget(self, action: #selector(addFavorite), for: UIControl.Event.touchUpInside)
        
        cell?.sendMessage.accessibilityHint = String (indexPath.row)
        cell?.sendMessage.addTarget(self, action: #selector(sendMessage), for: UIControl.Event.touchUpInside)
        
        return cell!
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        print("didselect")
//        print(patientItem [indexPath.row].mr_no)
//        mr_no =  patientItem [indexPath.row].mr_no
//        PatientName = patientItem[indexPath.row].name
//    }

 var dateOfBirth = ""
 var patientPhone = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didselect")
        print(patientItem [indexPath.row].mr_no)
        mr_no =  patientItem [indexPath.row].mr_no
        PatientName = patientItem[indexPath.row].name
       dateOfBirth = patientItem[indexPath.row].dateOfBirth
       patientPhone = patientItem[indexPath.row].Phone
        
        
    }
    
    @IBAction func addFavorite(sender: UIButton) -> Void {
        
        
        let indexpath  = sender.accessibilityHint
        
      PatientName = patientItem[Int(indexpath!)!].name
      mr_no = patientItem[Int(indexpath!)!].mr_no
        dateOfBirth = patientItem[Int(indexpath!)!].dateOfBirth
        patientPhone = patientItem[Int(indexpath!)!].Phone
        performSegue(withIdentifier: "patientDetails", sender: self)
    }
    @IBAction func sendMessage(sender: UIButton) -> Void {
        
        self.activityProgress.isHidden = false

        let indexpath  = sender.accessibilityHint
        
        PatientName = patientItem[Int(indexpath!)!].name
        mr_no = patientItem[Int(indexpath!)!].mr_no
        
        
         let db = Firestore.firestore()
        
        let doctorAcessToChatWithPatient : DocumentReference?
        doctorAcessToChatWithPatient = db.collection("tokensListPatients").document(mr_no)
        
        
        doctorAcessToChatWithPatient?.getDocument { (document, error) in
            
            self.activityProgress.isHidden = true
            if let document = document, document.exists {
             self.performSegue(withIdentifier: "sendMessage", sender: self)

            } else {

                self.createAlert(title: "U Dont Have Premisson to access", message: "Attention")

            }
        }
        
       
        
    }
 
    var   mr_no = ""
    var   PatientName = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "patientDetails") {
            // initialize new view controller and cast it as your view controller
            let ViewPatientProfileViewController = segue.destination as! ViewPatientProfileViewController
            
            ViewPatientProfileViewController.mr_no = mr_no
            ViewPatientProfileViewController.PatientName = PatientName
            ViewPatientProfileViewController.patientPhone = patientPhone
            ViewPatientProfileViewController.dateOfBirth = dateOfBirth
          
            
        }
        if (segue.identifier == "sendMessage") {
            // initialize new view controller and cast it as your view controller
            let ChatWithPatient = segue.destination as! ChatWithPatient
            ChatWithPatient.PatientName = PatientName

            ChatWithPatient.mr_no = mr_no
            
            
        }
        
    }
    
    @IBOutlet weak var MRNOTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchClicked: UIButton!
    
    
    @IBAction func searchClicked(_ sender: Any) {
        
        searchView.isHidden = false
        
    }
    
    @IBOutlet weak var doneClicked: UIButton!

    @IBAction func doneClicked(_ sender: Any) {
        searchView.isHidden = true

    }
    var Dict = [String: String]()

    @IBAction func searchButtonClikced(_ sender: Any) {
        
        self.activityProgress.isHidden  = false

        
        Dict = ["mr_no":MRNOTextField.text,"first_name":firstNameTextField.text,"phone_no":phoneTextField.text] as! [String : String]

        if let getRequest_handler_key = helper.getRequest_handler_key(){
            API.getPatientSearch(request_handler_key: getRequest_handler_key, serachDic: Dict){ (satutsCode:Int ,patient:[Patient]?)in
                self.activityProgress.isHidden  = true
                self.searchView.isHidden = true

                if (satutsCode == 0)
                {
                    self.createAlert(title: "No Internet Connection", message: "Error")
                }
                    
                else{
                    if (satutsCode == 1022 )
                    
                    {
                       
                        self.createAlert(title: "No patient found for the given search criteria", message: "error")
                        print("Hello from services Page")
                        
                        
                        if let PatientServices = patient
                        {
                            self.patientItem = PatientServices
                            self.patientTableView.reloadData()
                        }
                    }
                    if (satutsCode == 200 )
                    {
                        // 1980-04-15 201118021110 MR012120
                        print("Hello from services Page")
                        
                        
                        if let PatientServices = patient
                        {
                            self.patientItem = PatientServices
                            self.patientTableView.reloadData()
                        }
                    }
                    if (satutsCode == 1001)
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
//

    @IBOutlet weak var searchButtonCliked: UIButton!
    @IBOutlet weak var searchCliked: UIButton!
}
