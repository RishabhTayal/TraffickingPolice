//
//  LoginViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        let permissions = ["public_profile"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                if user!.isNew {
                    
                } else {
                    
                }
                let app = UIApplication.sharedApplication().delegate as! AppDelegate
                app.showMainScreen()
            } else {
            }
        }
    }
}