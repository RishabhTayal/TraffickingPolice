//
//  ReportedDetailViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/25/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class ReportedDetailViewController: ReportViewController {
    
    var reportObject: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "actionButtonTapped:")
        
        configureValues()
    }
    
    func actionButtonTapped(sender: AnyObject) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report as Abuse Content", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            self.reportObject.setValue(true, forKey: "abusiveContent")
            self.reportObject.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                let alert = UIAlertController(title: "Reported abusive content", message: nil, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            })
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func configureValues() {
        for key in reportObject.allKeys {
            let row = form.formRowWithTag(key)
            if let file = reportObject[key] as? PFFile {
                print("file")
                file.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                    row?.value = UIImage(data: data!)
                    self.tableView.reloadData()
                })
            } else if let location = reportObject[key] as? PFGeoPoint {
                print("locatiom")
                row?.value = true
                AppHelper.getDisplayLocationFromLocation(location, completion: { (locationString) -> Void in
                    let section = row?.sectionDescriptor
                    section?.footerTitle = locationString
                    self.tableView.reloadData()
                })
            } else if let value = reportObject[key] {
                if value is NSNull {
                    
                } else {
                    row?.value = value
                }
            }
        }
    }
    
    override func initialForm() {
        super.initialForm()
        form.disabled = true
    }
}
