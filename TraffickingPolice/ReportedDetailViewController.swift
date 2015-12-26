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
        
        configureValues()
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
                AppHelper.getDisplayLocationFromLocation(location, completion: { (placemark) -> Void in
                    let section = row?.sectionDescriptor
                    if let city = placemark.locality {
                        section!.footerTitle = city
                    } else {
                        section!.footerTitle = "Location added"
                    }
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
