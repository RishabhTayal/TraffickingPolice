//
//  MainViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/22/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import PulsingHalo

class MainViewController: UIViewController {
    
    @IBOutlet var reportButton: UIButton!
    var halo: PulsingHaloLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportButton.roundView()
        reportButton.layer.shadowColor = UIColor.blackColor().CGColor
        reportButton.layer.shadowRadius = 6
        reportButton.layer.shadowOffset = CGSizeMake(0, 0)
        reportButton.layer.masksToBounds = false
        reportButton.layer.shadowOpacity = 0.5
        
        halo = PulsingHaloLayer()
        halo.radius = reportButton.frame.size.width + 60
        halo.backgroundColor = reportButton.backgroundColor?.CGColor
        reportButton.superview?.layer.insertSublayer(halo, below: reportButton.layer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        halo.position = reportButton.center
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ReportViewController") as! ReportViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}