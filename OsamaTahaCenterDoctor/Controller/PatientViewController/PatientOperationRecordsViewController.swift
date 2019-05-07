//
//  PatientOperationRecordsViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 4/9/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class PatientOperationRecordsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UIPickerViewDelegate,UIPickerViewDataSource{
  
  
    @IBOutlet weak var subscribeView: CustomView!
    
    @IBOutlet weak var sbuscribeButton: UIButton!
    @IBOutlet weak var patientOperationPickerView: UIPickerView!
    @IBOutlet weak var patientOperationTableView: UITableView!
    var mr_no = ""
 var patientNameText = ""
    
    
 var operationId = 0
    
    var patientOperationItens = [PatientOperationOdoo]()
    var allOperations = [PatientOperationOdoo]()

    var allOperationsAfterFilter = [PatientOperationOdoo]()

    
    @IBOutlet weak var patientName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientName.text = patientNameText
        
        patientOperationPickerView.delegate = self
        patientOperationPickerView.dataSource = self

        patientOperationTableView.dataSource = self
        
        patientOperationTableView.delegate = self
        
   
        
        odooAPI.getPatientOperation( ){(error:Bool,onlySelectedOperation:[PatientOperationOdoo])in
            
            if (error)
            {
                odooAPI.getAllPatientLst( ){(error:Bool,allPatientOperation:[PatientOperationOdoo])in
                    
                    if (error)
                    {
                        
                        
                        print("only selected operation")
                        print(onlySelectedOperation)
                        
                        self.patientOperationItens = onlySelectedOperation

                      
                        self.allOperations = allPatientOperation
                        
                        
                        
                        
                        var allPatientOperationNames = allPatientOperation.map { $0.name }
//
                        var onlySelectedOperationNames = onlySelectedOperation.map { $0.name }

                    
                        
                        
                        for (key,value) in allPatientOperationNames.enumerated()
                        {

                            if  onlySelectedOperationNames.contains(value) {
                           

                            }
                            else{
                                self.allOperationsAfterFilter.append(allPatientOperation[key])
                                
                            }
                          
                        }
                        if self.allOperationsAfterFilter.isEmpty{
                            
                            self.patientOperationPickerView.isHidden = true
                            
                            self.subscribeView.isHidden = true
                            self.sbuscribeButton.isHidden = true
                            self.createAlert(title: "NO Operation", message: "")
                            
                        }
                        else{
                            
                            self.patientOperationPickerView.isHidden = false
                            self.subscribeView.isHidden = false
                            self.sbuscribeButton.isHidden = false
                        }
                        
                        self.patientOperationTableView.reloadData()

                        self.patientOperationPickerView.reloadAllComponents()
                        
                    }
                    else{
                        
                    }
                    
                    
                }

                self.patientOperationTableView.reloadData()
                
                self.patientOperationPickerView.reloadAllComponents()
            }
            else{
             
                
            }
            
          
            
        }
        
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "Operation Subscribe"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(patientOperationItens.count)
        return patientOperationItens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientOperationCell", for: indexPath) as? PatientOperationCell
        
        cell?.name.text = patientOperationItens[indexPath.row].name
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allOperationsAfterFilter.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        print(allOperations)
        
        return allOperationsAfterFilter[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(self.allOperations[row].name)
        
        print(row)
        if !self.allOperationsAfterFilter.isEmpty
        {
            self.operationId = Int(self.allOperationsAfterFilter[row].id)!

        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
     
        self.patientOperationTableView.reloadData()
        
        self.patientOperationPickerView.reloadAllComponents()
    }

    @IBAction func subscribeClicked(_ sender: Any) {
       
        if self.operationId == 0 {
            self.createAlert(title: "Plz selecet an Operation ", message: "Error")
        }
        
      
        else {
        odooAPI.subscribeToPatientOperation( operationId: self.operationId){(error:Bool,allPatientOperation:Int)in
            self.patientOperationTableView.reloadData()
            
            self.patientOperationPickerView.reloadAllComponents()
            

            self.performSegue(withIdentifier: "FromSubscrbeToFirst", sender: nil)

            self.createAlert(title: "Sucess", message: "True")
            
           }
        }
        
    }
}
