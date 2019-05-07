//
//  ViewPatientProfileViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/5/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import Firebase
class ViewPatientProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var patientOperation: UIButton!
    @IBOutlet weak var medicalRecord: UIButton!
    @IBOutlet weak var notifcationMessage: UITextField!
    @IBOutlet weak var notifcationTitle: UITextField!
    @IBOutlet weak var activeProgress: UIActivityIndicatorView!
    @IBOutlet weak var pushNotifcationView: CustomView!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var ViewProfileTableViewAppointment: UITableView!
    var   mr_no = ""
    var   PatientName = ""
    var   dateOfBirth = ""
    var   patientPhone = ""
    
    
    var myPatientAppointmentItem = [patientAppintment]()
    override func viewDidLoad() {
        super.viewDidLoad()
print("hello i am in view didload of profile and this is mr_no of me \(mr_no)\(PatientName)")
        
        ViewProfileTableViewAppointment.dataSource = self
        ViewProfileTableViewAppointment.delegate = self
        
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Patient Profile"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        patientName.text = PatientName
        
        
        if let getRequest_handler_key = helper.getRequest_handler_key(){
            API.getPatientAppointment(request_handler_key: getRequest_handler_key, mr_no: mr_no){ (satutsCode:Int ,patient:[patientAppintment]?)in
                //                self.activityProgress.isHidden  = true
                
                if (satutsCode == 0)
                {
                    self.createAlert(title: "No Internet Connection", message: "Error")
                }
                    
                else{
                    if (satutsCode == 200)
                    {
                        
                        print("Hello get patient details")
                        
                        
                        if let PatientServices = patient
                        {
                            self.myPatientAppointmentItem = PatientServices
                            self.ViewProfileTableViewAppointment.reloadData()
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
        return myPatientAppointmentItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAppoinmentCell", for: indexPath) as? MyAppoinmentCell
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"//this your string date format
        dateFormatter.timeZone = TimeZone(identifier: "UTC +2")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        let convertedDate = dateFormatter.date(from: myPatientAppointmentItem[indexPath.row].date)
        
        dateFormatter.dateFormat = "yyyy MMM dd "///this is what you want to convert format
        dateFormatter.timeZone = TimeZone(identifier: "UTC +2")
        let formattedDate1 = dateFormatter.string(from: convertedDate!)
        
        dateFormatter.dateFormat = "HH:mm "///this is what you want to convert format
        
        
        cell?.DRName.text = myPatientAppointmentItem[indexPath.row].doctorNAme
        cell?.centerName.text = myPatientAppointmentItem[indexPath.row].centerName
        cell?.dateDay.text = formattedDate1
        cell?.status.text = myPatientAppointmentItem[indexPath.row].statues
        cell?.dayOfAppointment.text = formattedDate1
        cell?.timeInhours.text = dateFormatter.string(from: convertedDate!)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
        
        
    }
    

    @IBAction func medicalRedordsClicked(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "MedicalRecords", sender: self)
        
         
        
    }
    
    
    @IBAction func messageBtnClicked(_ sender: Any) {
   
    
        let db = Firestore.firestore()
        
        let doctorAcessToChatWithPatient : DocumentReference?
        doctorAcessToChatWithPatient = db.collection("tokensListPatients").document(mr_no)
        
        
        doctorAcessToChatWithPatient?.getDocument { (document, error) in
            if let document = document, document.exists {
                        self.performSegue(withIdentifier: "sendMessageProfile", sender: self)

            } else {
                
                self.createAlert(title: "U Dont Have Premisson to access", message: "Attention")
                
            }
        }
        

        
        
    
    }
    
    
   
    
    @IBAction func patientOperationClicked(_ sender: Any) {
        
self.activeProgress.isHidden = false
        
        
        odooAPI.checkUserIsExist(name: mr_no ){  (error:Bool,userIsExistInOdoo:Int) in
            
            if error{
                
            }
                
            else{
                self.activeProgress.isHidden = true
                print(userIsExistInOdoo)
                
                if (userIsExistInOdoo > 0)
                {

                    
                   self.performSegue(withIdentifier: "subscibrViewController", sender: self)
                    
                    helper.saveOdooId(token: userIsExistInOdoo)
                    
                }
                if (userIsExistInOdoo == 0)
                {
                    
                    self.createAlert(title: "you Cont Send push Notifcation User Is Not Exist", message: "error")
                    
                }
                
            }
        }
        
    }
    
    
    
    
    
    
    @IBAction func sendNotifcationIsClicked(_ sender: Any) {
  
        guard let notifcationTitle = notifcationTitle.text, !notifcationTitle.isEmpty else {
            
            
            self.createAlert(title: "Plz Set Notifcation Title", message: "error")
            return
        }
        guard let notifcationMessage = notifcationMessage.text, !notifcationMessage.isEmpty else {
            
            self.createAlert(title: "Plz Set Notifcation Message", message: "error")
            return
        }
        
        odooAPI.pushNotifcationToPatient(name: mr_no, title: notifcationTitle, message: notifcationMessage ){  (error:Bool,userIsExistInOdoo:String) in
            
            
                
        self.createAlert(title: "message", message: userIsExistInOdoo)
        }
       
        
        
        self.pushNotifcationView.isHidden = true
        medicalRecord.isEnabled = true
        patientOperation.isEnabled = true

    
    }
    
    @IBAction func pushNotifcationClicked(_ sender: Any) {
        
        medicalRecord.isEnabled = false
        patientOperation.isEnabled = false

        self.activeProgress.isHidden = false

        odooAPI.checkUserIsExist(name: mr_no ){  (error:Bool,userIsExistInOdoo:Int) in

            if error{
                
            }
                
            else{
                
                if (userIsExistInOdoo > 0)
                {
                    self.activeProgress.isHidden = true

                    self.pushNotifcationView.isHidden = false

                    helper.saveOdooId(token: userIsExistInOdoo)
                    
                    print("no four")
                    print(userIsExistInOdoo)
                }
                if (userIsExistInOdoo == 0)
                {
                    self.activeProgress.isHidden = true

                    self.createAlert(title: "you Cont Send push Notifcation User Is Not Exist", message: "error")
                    
                }
                
            }
        }
        
        print("hello from notifcation button")
        print(mr_no)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.pushNotifcationView.isHidden = true
        medicalRecord.isEnabled = true

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MedicalRecords") {
            // initialize new view controller and cast it as your view controller
            let MedicalRecordsViewController = segue.destination as! MedicalRecordsViewController
            
            MedicalRecordsViewController.mr_no = mr_no
            
            print("i go to medcal \(mr_no)")
        }
        if (segue.identifier == "sendMessageProfile") {
            // initialize new view controller and cast it as your view controller
            let ChatWithPatient = segue.destination as! ChatWithPatient
            
            ChatWithPatient.mr_no = mr_no
            ChatWithPatient.PatientName = PatientName

        }
        if (segue.identifier == "subscibrViewController") {
            // initialize new view controller and cast it as your view controller
            let PatientOperationRecordsViewController = segue.destination as! PatientOperationRecordsViewController
            
            PatientOperationRecordsViewController.mr_no = mr_no
            PatientOperationRecordsViewController.patientNameText = PatientName
            
        }
        
        
        
        
        
    }
    
    
    @IBAction func getPattientAccessClicked(_ sender: Any) {
        
        
        if let getRequest_handler_key = helper.getRequest_handler_key(){
            API.getPatientAccessMobile(request_handler_key: getRequest_handler_key, mr_no: mr_no, dateOfBirth: dateOfBirth, patientPhone: patientPhone){ (satutsCode:Int ,patient:[patientAppintment]?)in
                //                self.activityProgress.isHidden  = true
                
                if (satutsCode == 0)
                {
                    self.createAlert(title: "No Internet Connection", message: "Error")
                }
                    
                else{
                    if (satutsCode == 200)
                    {
                        
                        print("Hello get patient details")
                        
                        
                        if let PatientServices = patient
                        {
                            self.myPatientAppointmentItem = PatientServices
                            self.ViewProfileTableViewAppointment.reloadData()
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
        
        print("acesss password")
        print(patientPhone)
        print(PatientName)
        print(dateOfBirth)
        print(mr_no)

        print("acesss password")


        
        
    }
    
}
