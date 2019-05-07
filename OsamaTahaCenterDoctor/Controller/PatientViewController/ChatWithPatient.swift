//
//  ChatWithDROsama.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/13/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import Kingfisher
import MobileCoreServices
import IQKeyboardManagerSwift
import MessageToolbar
import AVFoundation
import SwiftAudio

class ChatWithPatient: UIViewController  ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIDocumentMenuDelegate,UIDocumentPickerDelegate,MessageToolbarDelegate
{
   
    
//    @IBOutlet weak var msViewBottomConstraint: NSLayoutConstraint!
    var audioPlayer: AVPlayer!

    @IBOutlet weak var voiceBTN: MessageToolbar!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    @IBOutlet weak var loadingView: CustomView!
    
    @IBOutlet weak var messageTextField: UITextField!
    var messageItem = [Message]()
    var doumentIdForLastMessage = ""
    var urlForOdf = ""
    var   mr_no = ""
    private var keyboardHeight: CGFloat = 0.0
    private var firstTime = true
    
    var PatientName = ""
    @IBOutlet weak var chatTableView: UITableView!


    
    @IBOutlet weak var msViewBottomConstraint: NSLayoutConstraint!

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
        
        
        voiceBTN.delegate = self
        
//        voiceBTN.enablePhotoPicking = false
        
        
        voiceBTN.pickImageButtonImage = UIImage(named: "cameraChat")
        
        voiceBTN.pickFielButtonImage = UIImage(named: "ic_description_black_24px")
        
        voiceBTN.enableVoiceRecord = false
        voiceBTN.pickFileButton.addTarget(self, action: #selector(self.clickFunction), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


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

         db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: mr_no)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {

                   if ( querySnapshot?.documents.count != 0 )
                   {
                    db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).collection("Conversations").order(by: "lastMessageDate", descending: false)
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
                                
                                if self.messageItem.count > 3
                                {
                                let indexPath = IndexPath(row: self.messageItem.count-1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                                }
                                else{
                                    let indexPath = IndexPath(row: 0, section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                         self.chatTableView.reloadData()
                   
                         }
                         }
                  
                     }
                   else{
                    let docDataFirstOneToChat: [String: Any] = [
                        "doctorId": helper.getdoctorID(),
                        
                        "doctorToken": "dH_D0aAp-l4:APA91bHRsC15nW6eLtvEkwGt8v2MJFchd268XUrbdPzODZEipBHJ-RZtwBTULm92k7mKuGLcqBVr00-jYEn4YXa2Zq4LZ5h6cregn6yf4GSvnsPGcj4Ixg7cDkEwZBOgwgF6-47wmY96" ,
                        "doctorUnreadMessage": 0,
                        "lastMessage":"wdsd",
                        "lastMessageDate":Timestamp(date: Date()),
                        "patientId":self.mr_no,
                        "patientName" :self.PatientName,
                        "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                        "patientUnreadMessage":  0
                        
                    ]
                    var ref: DocumentReference? = nil
                    
                    ref =   db.collection("DirectChat").addDocument(data: docDataFirstOneToChat){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            

                            db.collection("DirectChat").document((ref?.documentID)!).collection("Conversations").order(by: "lastMessageDate", descending: false)
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
                    }

                    }
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
//             let cons  =  NSLayoutConstraint(item: cell?.message, attribute: .trailing, relatedBy: .equal, toItem: cell?.chatIcon, attribute: .trailing, multiplier: 1, constant: 0)
                
//                cell?.backcolor.addConstraint(cons)

                
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
                cell.chatImage.contentMode = .scaleAspectFit
                cell.chatImage.kf.setImage(with: url)

                return cell
                
            }
            else{
                let cell = (tableView.dequeueReusableCell(withIdentifier: "ChatCellImageTRailing", for: indexPath) as? ChatCellImageTRailing)!
                let url = URL(string:messageItem[indexPath.row].message )
                cell.chatImage.contentMode = .scaleAspectFit

                cell.chatImage.kf.setImage(with: url)

                return cell

            }
            

            
        }
        else if messageItem[indexPath.row].messageType == 2{
            
            let cell = (tableView.dequeueReusableCell(withIdentifier: "chatFile", for: indexPath) as? chatFile)!
            
            if messageItem[indexPath.row].senderType == 1
            {
                cell.downloadFileLeading.isHidden = false
                cell.downloadFileTrailing.isHidden = true

                cell.downloadFileLeading.accessibilityHint = String(indexPath.row)

                cell.downloadFileLeading.addTarget(self, action: #selector(viewPdf), for: .touchUpInside)
            }
            else
            {
                cell.downloadFileLeading.isHidden = true

                cell.downloadFileTrailing.isHidden = false
                cell.downloadFileTrailing.accessibilityHint = String(indexPath.row)
                
                cell.downloadFileTrailing.addTarget(self, action: #selector(viewPdf), for: .touchUpInside)
            }
            
            return cell
        }

        else{
            let cell = (tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath) as? audioCell)!
            
            if messageItem[indexPath.row].senderType == 1
            {
                cell.playLeading.isHidden = false
                cell.playTrialing.isHidden = true
                
                cell.playLeading.accessibilityHint = String(indexPath.row)
                
                cell.playLeading.addTarget(self, action: #selector(playAudio(sender:)), for: .touchUpInside)
            }
            else
            {
                cell.playLeading.isHidden = true
                
                cell.playTrialing.isHidden = false
                cell.playTrialing.accessibilityHint = String(indexPath.row)
                
                cell.playTrialing.addTarget(self, action: #selector(playAudio(sender:)), for: .touchUpInside)
            }
            
            return cell
            
        }
        
    }

    @objc func viewPdf(sender: UIButton) -> Void {
        
        let indexPath  = sender.accessibilityHint

        
        self.urlForOdf = messageItem[Int(indexPath!)!].message
        
        performSegue(withIdentifier: "viewDownloadedPDF", sender: self)
    }
    @objc func playAudio(sender: UIButton) -> Void {
                let indexPath  = sender.accessibilityHint
//
//        var player = AudioPlayer()
//
//        let audioItem = DefaultAudioItem(audioUrl:messageItem[Int(indexPath!)!].message , sourceType: .stream)
//
//        do{
//
//            try  player.load(item: audioItem, playWhenReady: true)
//print("mostafa")
//            print(messageItem[Int(indexPath!)!].message)
//            player.volume = 10.0
//        player.play()
//
//        }
//
//
//        catch{
//
//
//        }
        
//
        
        
        let player =  AVPlayer(url: URL(string:messageItem[Int(indexPath!)!].message)! )
        let playerplay = AVPlayerLayer(player: player)
        
        view.layer.addSublayer(playerplay)
        player.play()
        player.status
    
     print( messageItem[Int(indexPath!)!].message)
    }
 
        
//        self.urlForOdf = messageItem[Int(indexPath!)!].message
        
//        performSegue(withIdentifier: "viewDownloadedPDF", sender: self)
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewDownloadedPDF") {
            // initialize new view controller and cast it as your view controller
            let viewDownloadedPdf = segue.destination as! viewDownloadedPdf
            
            viewDownloadedPdf.urlForOdf = urlForOdf
            
//            print("i go to medcal \(urlForOdf)")
        }
        
    }
    
    
    @IBAction func sendMessageClick(_ sender: Any) {
  
//        let db = Firestore.firestore()
//        self.loadingView.isHidden = false
//
////        messageItem = []
//
//        db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: mr_no)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//
//
//                    let docData: [String: Any] = [
//                            "lastMessageDate": Timestamp(date: Date()),
//
//                            "message": self.messageTextField.text ,
//                            "messageType": 0,
//                            "senderName":"wdsd",
//                            "senderType":0,
//
//                        ]
//                        db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).collection("Conversations").addDocument(data:docData) { err in
//                            if let err = err {
//                                print("Error writing document: \(err)")
//                            } else {
//                                print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
//                                self.loadingView.isHidden = true
//
//
//                            }
//                        }
//                    let docDataUpdateBaseDoument: [String: Any] = [
//                        "doctorId": helper.getdoctorID(),
//
//                        "doctorToken": helper.getDeviceToken() ,
//                        "doctorUnreadMessage": 0,
//                        "lastMessage":self.messageTextField.text,
//                        "lastMessageDate":Timestamp(date: Date()),
//                        "patientId":self.mr_no,
//                        "patientName" :self.PatientName,
//                        "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
//                        "patientUnreadMessage":  0
//
//                    ]; db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).updateData(docDataUpdateBaseDoument) { err in
//                        if let err = err {
//                            print("Error writing document: \(err)")
//                        } else {
//                            print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
//                            self.loadingView.isHidden = true
//
//
//                        }
//                    }
//
//
//                }
//        }
//
        
    
        
   

    
}
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        IQKeyboardManager.shared.enable = false

        textField.text = ""
//        IQKeyboardManager.shared.disabledToolbarClasses = [ChatWithPatient.self]
//        IQKeyboardManager.shared.disabledTouchResignedClasses = [ChatWithPatient.self]
//        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [ChatWithPatient.self]
//
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
//                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        IQKeyboardManager.shared.enable = false
        
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

        
        chatTableView.estimatedRowHeight = 50
        chatTableView.rowHeight =  UITableView.automaticDimension

    }

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.loadingView.isHidden = false

        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {

//
//            let db = Firestore.firestore()
//            let store = Storage.storage()
//            let storeRef = store.reference()
//            if let uploadData = image.pngData() {
//                let riversRef = storeRef.child(String( Int.random(in: 1..<1000000000000000000)))
//
//                // Upload the file to the path "images/rivers.jpg"
//                let uploadTask = riversRef.putData(uploadData, metadata: nil) { (metadata, error) in
//                    guard let metadata = metadata else {
//                        // Uh-oh, an error occurred!
//                        return
//                    }
//
//                    self.loadingView.isHidden = true
//                    // Metadata contains file metadata such as size, content-type.
//                    let size = metadata.size
//                    // You can also access to download URL after upload.
//                    riversRef.downloadURL { (url, error) in
//                        guard let downloadURL = url else {
//                            // Uh-oh, an error occurred!
//                            return
//                        }
//
//
//
//
//                        db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: self.mr_no)
//                            .getDocuments() { (querySnapshot, err) in
//                                if let err = err {
//                                    print("Error getting documents: \(err)")
//                                } else {
//                                    for document in querySnapshot!.documents {
//                                        let docData: [String: Any] = [
//                                            "lastMessageDate": Timestamp(date: Date()),
//
//                                            "message": downloadURL.absoluteString,
//                                            "messageType": 1,
//                                            "senderName":"wdsd",
//                                            "senderType":0,
//
//                                            ]
//                                        db.collection("DirectChat").document(document.documentID).collection("Conversations").addDocument(data:docData) { err in
//                                            if let err = err {
//                                                print("Error writing document: \(err)")
//                                            } else {
//                                                print("Document successfully written!\(document.documentID)")
//                                            }
//                                        }
//
//                                        let docDataUpdateBaseDoument: [String: Any] = [
//                                            "doctorId": helper.getdoctorID(),
//
//                                            "doctorToken": helper.getDeviceToken() ,
//                                            "doctorUnreadMessage": 0,
//                                            "lastMessage":"📷",
//                                            "lastMessageDate":Timestamp(date: Date()),
//                                            "patientId":self.mr_no,
//                                            "patientName" :self.PatientName,
//                                            "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
//                                            "patientUnreadMessage":  0
//
//                                        ]; db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).updateData(docDataUpdateBaseDoument) { err in
//                                            if let err = err {
//                                                print("Error writing document: \(err)")
//                                            } else {
//                                                print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
//                                                self.loadingView.isHidden = true
//
//
//                                            }
//                                        }
//
//
//
//                                    }
//                                }
//                        }
//
//
//                    }
//
//                }
//
//
//            }
            
        }
        dismiss(animated: true, completion: nil)

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

                db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: self.mr_no)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let docData: [String: Any] = [
                                "lastMessageDate": Timestamp(date: Date()),
                                
                                "message": downloadURL.absoluteString,
                                "messageType": 2,
                                "senderName":"wdsd",
                                "senderType":0,
                                
                                ]
                            db.collection("DirectChat").document(document.documentID).collection("Conversations").addDocument(data:docData) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!\(document.documentID)")
                                }
                            }
                            
                            let docDataUpdateBaseDoument: [String: Any] = [
                                "doctorId": helper.getdoctorID(),
                                
                                "doctorToken": helper.getDeviceToken() ,
                                "doctorUnreadMessage": 0,
                                "lastMessage":"📄",
                                "lastMessageDate":Timestamp(date: Date()),
                                "patientId":self.mr_no,
                                "patientName" :self.PatientName,
                                "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                                "patientUnreadMessage":  0
                                
                            ]; db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).updateData(docDataUpdateBaseDoument) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
                                    self.loadingView.isHidden = true
                                    
                                    
                                }
                            }
                            
                        }
                    }
            }

        }
    }
    
    }
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    func didSend(message: String) {
        //        textLabel.text = message
        
        print(message)
        let db = Firestore.firestore()
        self.loadingView.isHidden = false
        
        //        messageItem = []
        
        db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: mr_no)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    
                    let docData: [String: Any] = [
                        "lastMessageDate": Timestamp(date: Date()),
                        
                        "message": message,
                        "messageType": 0,
                        "senderName":"wdsd",
                        "senderType":0,
                        
                        ]
                    db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).collection("Conversations").addDocument(data:docData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
                            self.loadingView.isHidden = true
                            
                            
                        }
                    }
                    let docDataUpdateBaseDoument: [String: Any] = [
                        "doctorId": helper.getdoctorID(),
                        
                        "doctorToken": helper.getDeviceToken() ,
                        "doctorUnreadMessage": 0,
                        "lastMessage":message,
                        "lastMessageDate":Timestamp(date: Date()),
                        "patientId":self.mr_no,
                        "patientName" :self.PatientName,
                        "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                        "patientUnreadMessage":  0
                        
                    ]; db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).updateData(docDataUpdateBaseDoument) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
                            self.loadingView.isHidden = true
                            
                            
                        }
                    }
                    
                    
                }
        }
        
        
    }
    func didFinish(recording voice: Data) {
        
        
        let db = Firestore.firestore()
        let store = Storage.storage()
        let storeRef = store.reference()
        
        let riversRef = storeRef.child(String( Int.random(in: 1..<1000000000000000000)))
        
        let metadata  = StorageMetadata()
        metadata.contentType = "audio/mpeg"
        
        
        
        let uploadTask = riversRef.putData(voice, metadata: metadata) { metadata, error in
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
                
                db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: self.mr_no)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                let docData: [String: Any] = [
                                    "lastMessageDate": Timestamp(date: Date()),
                                    
                                    "message": downloadURL.absoluteString,
                                    "messageType": 3,
                                    "senderName":"wdsd",
                                    "senderType":0,
                                    
                                    ]
                                db.collection("DirectChat").document(document.documentID).collection("Conversations").addDocument(data:docData) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!\(document.documentID)")
                                    }
                                }
                                
                                let docDataUpdateBaseDoument: [String: Any] = [
                                    "doctorId": helper.getdoctorID(),
                                    
                                    "doctorToken": helper.getDeviceToken() ,
                                    "doctorUnreadMessage": 0,
                                    "lastMessage":"📄",
                                    "lastMessageDate":Timestamp(date: Date()),
                                    "patientId":self.mr_no,
                                    "patientName" :self.PatientName,
                                    "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                                    "patientUnreadMessage":  0
                                    
                                ]; db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).updateData(docDataUpdateBaseDoument) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
                                        self.loadingView.isHidden = true
                                        
                                        
                                    }
                                }
                                
                            }
                        }
                }
                
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
            
            let metadata  = StorageMetadata()
            metadata.contentType = "image/jpg"
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putData(uploadData, metadata: metadata) { (metadata, error) in
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
                    
                    
                    
                    
                    db.collection("DirectChat").whereField("doctorId", isEqualTo: helper.getdoctorID()).whereField("patientId", isEqualTo: self.mr_no)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    let docData: [String: Any] = [
                                        "lastMessageDate": Timestamp(date: Date()),
                                        
                                        "message": downloadURL.absoluteString,
                                        "messageType": 1,
                                        "senderName":"wdsd",
                                        "senderType":0,
                                        
                                        ]
                                    db.collection("DirectChat").document(document.documentID).collection("Conversations").addDocument(data:docData) { err in
                                        if let err = err {
                                            print("Error writing document: \(err)")
                                        } else {
                                            print("Document successfully written!\(document.documentID)")
                                        }
                                    }
                                    
                                    let docDataUpdateBaseDoument: [String: Any] = [
                                        "doctorId": helper.getdoctorID(),
                                        
                                        "doctorToken": helper.getDeviceToken() ,
                                        "doctorUnreadMessage": 0,
                                        "lastMessage":"📷",
                                        "lastMessageDate":Timestamp(date: Date()),
                                        "patientId":self.mr_no,
                                        "patientName" :self.PatientName,
                                        "patientToken":"c4iW0nvVZWM:APA91bHl_jy-eOuAM_d8UGW1diiZ0ty6LuoyMZPcqEcLldz_eU0Z_aE0RMbglhuqAJwS9hgh7eEpTHFznOOH5PNYIO6GOVATZXhSfEG9rOESHcipXupFWjedTLX9xXJx5v4wUpmZWgFz",
                                        "patientUnreadMessage":  0
                                        
                                    ]; db.collection("DirectChat").document((querySnapshot?.documents[0].documentID)!).updateData(docDataUpdateBaseDoument) { err in
                                        if let err = err {
                                            print("Error writing document: \(err)")
                                        } else {
                                            print("Document successfully written!\(querySnapshot?.documents[0].documentID)")
                                            self.loadingView.isHidden = true
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                }
                            }
                    }
                    
                    
                }
                
            }
            
            
        }
    }
    
    
//    @objc func keyboardNotification(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//            let endFrameY = endFrame?.origin.y ?? 0
//            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
//            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
//            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
//            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
//            if endFrameY >= UIScreen.main.bounds.size.height {
//                self.keyboardHeightLayoutConstraint?.constant = 0.0
//            } else {
//                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
//            }
//            UIView.animate(withDuration: duration,
//                           delay: TimeInterval(0),
//                           options: animationCurve,
//                           animations: { self.view.layoutIfNeeded() },
//                           completion: nil)
//        }
//    }
    
   @IBAction  func clickFunction(){
        
    
    let importMenu   = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
    
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    
}


/*
 
 /*  pa = 1  */
 */


/*
 
 db.collection("DirectChat").document(document.documentID).collection("Conversations")
 .addSnapshotListener { querySnapshot, error in
 guard let documents = querySnapshot?.documents else {
 print("Error fetching documents: \(error!)")
 return
 }
 
 
 for document in querySnapshot!.documents {
 
 
 let   Message1   =  Message(lastMessageDate: document.get("lastMessageDate") as! Date, message: document.get("message") as! String, messageType: document.get("messageType") as! Int, senderName: document.get("senderName") as! String, senderType: document.get("senderType") as! Int)
 
 
 self.messageItem.append(Message1)
 
 self.chatTableView.reloadData()
 
 
 
 }
 //                                let cities = documents.map { $0["name"]! }
 //                                print("Current cities in CA: \(cities)")
 }
 */


