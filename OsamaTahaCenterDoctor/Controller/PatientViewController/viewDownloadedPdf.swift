//
//  viewDownloadedPdf.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/20/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class viewDownloadedPdf: UIViewController {

    var urlForOdf = ""

    @IBOutlet weak var webviewChat: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.6941176471, blue: 0.8196078431, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        self.navigationItem.title = "pdf"
        let textAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        
        print("ho all i am in viewDownloadedPdf \(urlForOdf)")
        let url = URL(string: urlForOdf)
        let request = NSURLRequest(url: url!)
    
        webviewChat.loadRequest(request as URLRequest)
        
        
    }
    

  

}
