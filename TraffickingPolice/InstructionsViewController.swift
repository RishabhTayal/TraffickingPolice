//
//  InstructionsViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class InstructionsViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Instructions"
        
        let htmlFile = NSBundle.mainBundle().pathForResource("Instructions", ofType: "html")
        do {
            let htmlString = try NSString(contentsOfFile: htmlFile!, encoding: NSUTF8StringEncoding)
            webView.loadHTMLString(htmlString as String, baseURL: nil)
        } catch {
            
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logoutTapped:")
    }
    
    func logoutTapped(sender: AnyObject) {
        PFUser.logOut()
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.showLoginScreen()
    }
}
