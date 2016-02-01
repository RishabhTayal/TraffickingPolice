//
//  LoginViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: "Trafficking Police", message: "We will never post anything on Facebook without your permission. By clicking 'I Agree', you agree to terms.", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "I Agree", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            let permissions = ["public_profile"]
            PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) { (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    if user!.isNew {
                        
                    } else {
                        
                    }
                    
                    let graph: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name,last_name,name"])
                    graph.startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                        if let result = result {
                            user!["name"] = result["name"]
                            user?.saveInBackgroundWithBlock(nil)
                            let app = UIApplication.sharedApplication().delegate as! AppDelegate
                            app.showMainScreen()
                        }
                    })
                } else {
                    let alert = UIAlertController(title: "Could not login", message: "", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }))
        alertController.addAction((UIAlertAction(title: "Read Terms", style: .Default, handler: { (action: UIAlertAction) -> Void in
            let licenseVC = LicenseViewController(nibName: "LicenseViewController", bundle: nil) 
            self.presentViewController(UINavigationController(rootViewController: licenseVC), animated: true, completion: nil)
        })))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
