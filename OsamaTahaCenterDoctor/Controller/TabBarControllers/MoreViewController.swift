//
//  MoreViewController.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/7/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import MOLH

class MoreViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var closeLanguageView: UIButton!
    
    @IBOutlet weak var languageView: UIView!
    
    
    @IBOutlet weak var arabicView: CustomView!
    @IBOutlet weak var englishView: CustomView!
    @IBOutlet weak var iconEngliahShadow: CustomView!
    
    @IBOutlet weak var arabicChangeIcon: UIImageView!
    @IBOutlet weak var EnglishChangeIcon: UIImageView!
    @IBOutlet weak var changeIconShadowView: UIView!
    
    @IBOutlet weak var moreTableView: UITableView!
    var arrayOfMoreOPtionE = ["Live Chat","Inbox","Contact Info.","About App","Language (English)"]
    
    
    var arrayOfMoreOPtionA = ["شات مباشر ","الخاص","معلومات الاتصال","   ماذا عنا","تغيير اللغه"]
    
    var arrayUser = [String]()
    
    
    @IBAction func closeLanguageClicked(_ sender: Any) {
        
        
        languageView.isHidden = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        moreTableView.dataSource = self
        moreTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        let def = UserDefaults.standard
        
        if let langs = def.object(forKey: "AppleLanguages") as? NSArray{
            print(langs.firstObject)
            
            if langs.firstObject as? String == "ar"
            {
                
                arrayUser = arrayOfMoreOPtionA
            }
            else{
                
                arrayUser = arrayOfMoreOPtionE
            }
            
            //            def.synchronize()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as? MoreTableViewCell {
            
            if indexPath.row == 7
            {
                
                cell.arrow.isHidden = true
                cell.changeLang.isHidden = false
            }
            else{
                
                cell.arrow.isHidden = false
                cell.changeLang.isHidden = true
                
            }
            
            cell.moreOptionLabel.text = arrayUser[indexPath.row]
            return cell
            
        }
        
        return  MoreTableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
          
        switch indexPath.row {
        case 1:
        
            let vc = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "PatientInboxViewController") as? PatientInboxViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            break
        
        case 0:

            let vc = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "LiveChatViewController") as? LiveChatViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            break
        case 2:
            
            
            let vc = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            break
//
//        case 4 :
//            let vc = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendUsViewController") as? SendUsViewController
//            self.navigationController?.pushViewController(vc!, animated: true)
//            break
//
//
        case 3 :
            let vc = UIStoryboard.init(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutAppViewController") as? AboutAppViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
            break
            

        case 4:
            
            //           let modalViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChangeLanguageViewController") as? ChangeLanguageViewController
            //               modalViewController?.modalPresentationStyle = .overCurrentContext
            //               self.navigationController?.present(modalViewController!, animated: true, completion: nil)
            //               self.tabBarController?.tabBar.isHidden = true
            self.languageView.isHidden = false
            break
        default:
            break
        }
    }
    
    @IBAction func ButtonEnglishClicked(_ sender: Any) {
        
        englishView.borderColor = #colorLiteral(red: 0.1215686275, green: 0.737254902, blue: 0.8470588235, alpha: 1)
        arabicView.borderColor = #colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.6823529412, alpha: 1)
        
        EnglishChangeIcon.image = UIImage(named: "blueLanguagechangeIcon")
        
        arabicChangeIcon.image = UIImage(named: "greyLabguageChangeIcon")
        
        
        MOLH.setLanguageTo("en")
        MOLH.reset()
        helper.restartApp()
        
        
        
        
    }
    
    @IBAction func buttonArabicClicked(_ sender: Any) {
        
        englishView.borderColor = #colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.6823529412, alpha: 1)
        arabicView.borderColor = #colorLiteral(red: 0.1215686275, green: 0.737254902, blue: 0.8470588235, alpha: 1)
        EnglishChangeIcon.image = UIImage(named: "greyLabguageChangeIcon")
        arabicChangeIcon.image = UIImage(named: "blueLanguagechangeIcon")
        
        MOLH.setLanguageTo("ar")
        
        MOLH.reset()
        
        helper.restartApp()
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
        //
        //        let MoreViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MoreViewController") as? MoreViewController
        //
        //
        //        MoreViewController?.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
}

