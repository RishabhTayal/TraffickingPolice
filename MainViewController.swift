//
//  MainViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/22/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var reportButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportButton.roundView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ReportViewController") as! ReportViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
