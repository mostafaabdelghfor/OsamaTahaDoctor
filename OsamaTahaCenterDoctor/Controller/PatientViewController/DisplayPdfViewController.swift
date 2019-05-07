//
//  DisplayPdfViewController.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 4/21/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class DisplayPdfViewController: UIViewController {

    @IBOutlet weak var activityProgress: UIActivityIndicatorView!
    var pdfURL =  ""
    var destinationURLForFile:URL?
 var visitId = ""
    
    var main = "https://api.instahealthsolutions.com/osama_t/"
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityProgress.isHidden = false
        
//        self.createAlert(title: self.pdfURL, message: self.pdfURL)
        
                _ = FileManager()
        
                let pathComponent = "dp"+String(00)+".pdf"
                let directoryURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let folderPath: URL = directoryURL.appendingPathComponent("Downloads", isDirectory: true)
                let fileURL: URL = folderPath.appendingPathComponent(pathComponent)
                self.destinationURLForFile = fileURL
        
                let url = URLS.getPatientsVisitsPDF
        
        
                let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                }
                let header = [
                    "request_handler_key": helper.getRequest_handler_key(),
                    ]
    
                let parameters = [
                    "visitId": visitId,
        
                ]
        
        
                API.Manager.download(
                   main + pdfURL,
                    method: .get,
                    parameters: parameters,
                    encoding: URLEncoding.default,
                    headers: header as! HTTPHeaders ,
                    to: destination).downloadProgress(closure: { (progress) in
                        //progress closure
                    }).response(completionHandler: { (DefaultDownloadResponse) in
                        //here you able to access the DefaultDownloadResponse
                        //result closure
        self.activityProgress.isHidden = true
        
                        print("status code of pdf\(DefaultDownloadResponse.response?.statusCode)")
        
                        if (DefaultDownloadResponse.response?.statusCode != 200){
        
                            self.createAlert(title: "error", message: "error")
                        }
                        else{
                        let pdfUrl = URL(fileURLWithPath: (self.destinationURLForFile?.path)!)
                        let requestObj = NSURLRequest(url: pdfUrl as URL)
                        self.webView?.loadRequest(requestObj as URLRequest)
                        }
                    })
        print("hello from display PDF")
        print(pdfURL)
        print(visitId)
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
