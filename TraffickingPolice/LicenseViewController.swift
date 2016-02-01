//
//  LicenseViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 2/1/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let htmlFile = NSBundle.mainBundle().pathForResource("EULA", ofType: "html")
        do {
            let htmlString = try NSString(contentsOfFile: htmlFile!, encoding: NSUTF8StringEncoding)
            webView.loadHTMLString(htmlString as String, baseURL: nil)
        } catch {
            
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelTapped:")
    }
    
    func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
