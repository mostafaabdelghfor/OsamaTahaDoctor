//
//  ChatwithPatientInGroup.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/26/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//



import UIKit
import FirebaseFirestore
import Firebase
import Kingfisher
import MobileCoreServices
import MessageToolbar
class ChatwithPatientInGroup: UIViewController  ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,MessageToolbarDelegate
{
    func didSend(message: String) {
        
        let db = Firestore.firestore()
        //        self.loadingView.isHidden = false
        
        //        messageItem = []
        
        let docData: [String: Any] = [
            "lastMessageDate": Timestamp(date: Date()),
            
            "message":message,
            "messageType": 0,
            "senderName":helper.getdoctorID(),
            "senderType":0,
            
            ]
        db.collection(groupId).document(patientId).collection("Conversations").addDocument(data:docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                
                //                self.loadingView.isHidden = true
                
                
            }
        }
        let docDataUpdateBaseDoument: [String: Any] = [
            "doctorId": helper.getdoctorID(),
            
            "doctorToken": helper.getDeviceToken() ,
            "doctorUnreadMessage": 0,
            "lastMessage":message,
            "lastMessageDate":Timestamp(date: Date()),
            "patientId":self.patientId,
            "patientName" :self.PatientName,
            "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
            "patientUnreadMessage":  0
            
        ]; db.collection(groupId).document(patientId).updateData(docDataUpdateBaseDoument) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                
                //                self.loadingView.isHidden = true
                
                
            }
        }
    }
    func didFinish(picking image: UIImage) {
        self.loadingView.isHidden = false
        
        
            
            let db = Firestore.firestore()
            let store = Storage.storage()
            let storeRef = store.reference()
            if let uploadData = image.pngData() {
                let riversRef = storeRef.child(String( Int.random(in: 1..<1000000000000000000)))
                
                // Upload the file to the path "images/rivers.jpg"
                let uploadTask = riversRef.putData(uploadData, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    
                    self.loadingView.isHidden = true
                    // Metadata contains file metadata such as size, content-type.
                    let size = metadata.size
                    // You can also access to download URL after upload.
                    riversRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            // Uh-oh, an error occurred!
                            return
                        }
                        
                        
                        
                        let docData: [String: Any] = [
                            "lastMessageDate": Timestamp(date: Date()),
                            
                            "message": downloadURL.absoluteString,
                            "messageType": 1,
                            "senderName":helper.getdoctorID(),
                            "senderType":0,
                            
                            ]
                        db.collection(self.groupId).document(self.patientId).collection("Conversations").addDocument(data:docData) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                            }
                        }
                        
                        let docDataUpdateBaseDoument: [String: Any] = [
                            "doctorId": helper.getdoctorID(),
                            
                            "doctorToken": helper.getDeviceToken() ,
                            "doctorUnreadMessage": 0,
                            "lastMessage":"📷",
                            "lastMessageDate":Timestamp(date: Date()),
                            "patientId":self.patientId,
                            "patientName" :self.PatientName,
                            "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                            "patientUnreadMessage":  0
                            
                        ]; db.collection(self.groupId).document(self.patientId).updateData(docDataUpdateBaseDoument) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                
                                self.loadingView.isHidden = true
                                
                                
                            }
                        }
                        
                        
                    }
                    
                }
                
                
            }
            
       
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var chatView: MessageToolbar!
    
    @IBOutlet weak var loadingView: CustomView!
    
    @IBOutlet weak var messageTextField: UITextField!
    var messageItem = [Message]()
    var doumentIdForLastMessage = ""
    var urlForOdf = ""
    var   mr_no = ""
    var PatientName = ""
    
    var patientId = ""
    var groupId = ""
    private var keyboardHeight: CGFloat = 0.0
    private var firstTime = true
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var msviewBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet private weak var outSafeArea: UIView!
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.pickImageButtonImage = UIImage(named: "cameraChat")
        
        chatView.pickFielButtonImage = UIImage(named: "ic_description_black_24px")
        
        chatView.enableVoiceRecord = false
        chatView.pickFileButton.addTarget(self, action: #selector(self.clickFunction), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


        print("mosstafa\(patientId)")
        print("group Id")
        print(groupId)
        
        chatView.delegate = self
        //        chatTableView.rowHeight = UITableView.automaticDimension
        //        chatTableView.estimatedRowHeight = 60
        
        self.tabBarController?.tabBar.isHidden = true
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
//        messageTextField.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = PatientName
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        let db = Firestore.firestore()
        
        db.collection(groupId).document(patientId).collection("Conversations").order(by: "lastMessageDate", descending: false)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.messageItem = []
                
                for document in querySnapshot!.documents {
                    
                    let   Message1   =  Message(lastMessageDate: document.get("lastMessageDate") as! Date, message: document.get("message") as! String, messageType: document.get("messageType") as! Int, senderName: document.get("senderName") as! String, senderType: document.get("senderType") as! Int)
                    
                    self.messageItem.append(Message1)
                    
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(row: self.messageItem.count-1, section: 0)
                        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                    }
                    self.chatTableView.reloadData()
                    
                }
        }
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messageItem[indexPath.row].messageType == 0
        {
            
            let   cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatCell
            
            if messageItem[indexPath.row].senderType == 1
            {
                
                
                cell?.backcolor.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell?.message.text = messageItem[indexPath.row].message
                cell?.stack.alignment = .leading
                cell?.message.translatesAutoresizingMaskIntoConstraints = false
                cell?.name.text = messageItem[indexPath.row].senderName
                //             let cons  =  NSLayoutConstraint(item: cell?.message, attribute: .trailing, relatedBy: .equal, toItem: cell?.chatIcon, attribute: .trailing, multiplier: 1, constant: 0)
                
                //                cell?.backcolor.addConstraint(cons)
                
                cell?.name.textColor = #colorLiteral(red: 0.1607843137, green: 0.1960784314, blue: 0.2549019608, alpha: 1)
                cell?.message.textColor = #colorLiteral(red: 0.1607843137, green: 0.1960784314, blue: 0.2549019608, alpha: 1)
                cell?.message.textAlignment = .left
                
                cell?.dateLabel.textColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6352941176, alpha: 1)
                
                cell?.dateLabel.textAlignment = .left
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
                dateFormatter.timeZone = TimeZone(identifier: "UTC +2")
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                let convertedDate  = dateFormatter.string(from: messageItem[indexPath.row].lastMessageDate)
                
                
                cell?.dateLabel.text = convertedDate
                
                cell?.backcolor.layer.cornerRadius = 15
                
                cell?.backcolor.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner, .layerMaxXMaxYCorner]
                
                //
                //            if messageItem[indexPath.row].messageType == 1
                //              {
                //
                //                cell?.message.isHidden = true
                //                cell?.chatImage.isHidden = false
                //                cell?.dateLabel.isHidden = true
                //                cell?.chatIcon.isHidden = true
                //                let url = URL(string:messageItem[indexPath.row].message )
                //
                //                cell?.chatImage.kf.setImage(with: url)
                //
                ////                cell?.chatImage.image = UIImage(named: messageItem[indexPath.row].message)
                //
                //               }
                
            }
            else
            {
                cell?.backcolor.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5882352941, blue: 0.6549019608, alpha: 1)
                cell?.message.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell?.message.textAlignment = .right
                cell?.dateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell?.dateLabel.textAlignment = .right
                cell?.name.text = messageItem[indexPath.row].senderName

                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
                dateFormatter.timeZone = TimeZone(identifier: "UTC +2")
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                let convertedDate  = dateFormatter.string(from: messageItem[indexPath.row].lastMessageDate)
                
                
                cell?.dateLabel.text = convertedDate
                
                //                cell?.chatIcon.isHidden = false
                
                cell?.stack.alignment = .trailing
                cell?.backcolor.layer.cornerRadius = 15
                cell?.backcolor.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMinYCorner]
                
                cell?.message.text = messageItem[indexPath.row].message
                
                //            if messageItem[indexPath.row].messageType == 1
                //            {
                //                cell?.message.isHidden = true
                //
                //                cell?.chatImage.isHidden = false
                //
                //                cell?.dateLabel.isHidden = true
                //                cell?.chatIcon.isHidden = true
                //
                //
                //
                //                let url = URL(string:messageItem[indexPath.row].message )
                //
                //                cell?.chatImage.kf.setImage(with: url)
                //
                //
                //
                //
                ////                cell?.chatImage.image = UIImage(named: messageItem[indexPath.row].message)
                //            }
            }
            return cell!
            
        }
        else if messageItem[indexPath.row].messageType == 1 {
            
            
            if messageItem[indexPath.row].senderType == 1 {
                
                let cell = (tableView.dequeueReusableCell(withIdentifier: "ChatCellImage", for: indexPath) as? ChatCellImage)!
                let url = URL(string:messageItem[indexPath.row].message )
                
                cell.chatImage.kf.setImage(with: url)
                cell.name.text = messageItem[indexPath.row].senderName

                return cell
                
            }
            else{
                let cell = (tableView.dequeueReusableCell(withIdentifier: "ChatCellImageTRailing", for: indexPath) as? ChatCellImageTRailing)!
                let url = URL(string:messageItem[indexPath.row].message )
                
                cell.chatImage.kf.setImage(with: url)
                cell.name.text = messageItem[indexPath.row].senderName

                return cell
                
            }
            
            
            
        }
        else{
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "chatFile", for: indexPath) as? chatFile)!
            
            if messageItem[indexPath.row].senderType == 1
            {
                cell.downloadFileLeading.isHidden = false
                cell.downloadFileTrailing.isHidden = true
                
                cell.nameTrailing.isHidden = true
                cell.nameleaading.isHidden = false

                
                cell.nameleaading.text = messageItem[indexPath.row].senderName

                
                cell.downloadFileLeading.accessibilityHint = String(indexPath.row)
                
                cell.downloadFileLeading.addTarget(self, action: #selector(viewPdf), for: .touchUpInside)
            }
            else
            {
                cell.downloadFileLeading.isHidden = true
                
                cell.downloadFileTrailing.isHidden = false
                
                cell.nameTrailing.isHidden = false
                cell.nameleaading.isHidden = true
                
                cell.nameTrailing.text = messageItem[indexPath.row].senderName
                
                cell.downloadFileTrailing.accessibilityHint = String(indexPath.row)
                
                cell.downloadFileTrailing.addTarget(self, action: #selector(viewPdf), for: .touchUpInside)
            }
            
            return cell
        }
        
    }
    
    @objc func viewPdf(sender: UIButton) -> Void {
        
        let indexPath  = sender.accessibilityHint
        
        
        self.urlForOdf = messageItem[Int(indexPath!)!].message
        
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Patient", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewDownloadedPdf") as! viewDownloadedPdf
        vc.urlForOdf = urlForOdf
        self.show(vc, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewDownloadedPDF") {
            // initialize new view controller and cast it as your view controller
            let viewDownloadedPdf = segue.destination as! viewDownloadedPdf
            
            viewDownloadedPdf.urlForOdf = urlForOdf
            
            //            print("i go to medcal \(urlForOdf)")
        }
        
    }
    
    
    @IBAction func sendMessageClick(_ sender: Any) {
    
        

        
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        textField.text = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        chatTableView.estimatedRowHeight = 50
        chatTableView.rowHeight =  UITableView.automaticDimension
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        
    }
    
    @IBAction func buUpload(_ sender: Any) {
        let imagepicker = UIImagePickerController()
        //        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        //            imagepicker.sourceType = .camera
        //        }else {
        imagepicker.sourceType = .photoLibrary
        //        }
        imagepicker.allowsEditing = true
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
        
        
        
        
    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let myURL =  url as URL
        print("import result : \(myURL)\(url)")
        
        self.loadingView.isHidden = false
        
        
        
        let db = Firestore.firestore()
        let store = Storage.storage()
        let storeRef = store.reference()
        
        let riversRef = storeRef.child(String( Int.random(in: 1..<1000000000000000000)))
        
        
        
        
        let uploadTask = riversRef.putFile(from: myURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                self.loadingView.isHidden = true
                
                let docData: [String: Any] = [
                    "lastMessageDate": Timestamp(date: Date()),
                    
                    "message": downloadURL.absoluteString,
                    "messageType": 2,
                    "senderName":helper.getdoctorID(),
                    "senderType":0,
                    
                    ]
                db.collection(self.groupId).document(self.patientId).collection("Conversations").addDocument(data:docData) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                    }
                }
                
                let docDataUpdateBaseDoument: [String: Any] = [
                    "doctorId": helper.getdoctorID(),
                    
                    "doctorToken": helper.getDeviceToken() ,
                    "doctorUnreadMessage": 0,
                    "lastMessage":"📄",
                    "lastMessageDate":Timestamp(date: Date()),
                    "patientId":self.patientId,
                    "patientName" :self.PatientName,
                    "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                    "patientUnreadMessage":  0
                    
                ]; db.collection(self.groupId).document(self.patientId).updateData(docDataUpdateBaseDoument) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                      
                        self.loadingView.isHidden = true
                        
                        
                    }
                }
            }
        }
        
    }
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    @IBAction  func clickFunction(){
        
        
        let importMenu   = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    
}

