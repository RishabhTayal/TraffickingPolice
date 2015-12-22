//
//  ReportedViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class ReportedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var datasourceArray: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reported"
        
        tableView = UITableView(frame: self.view.frame, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        let query = PFQuery(className: "Reported")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if let objects = objects {
                self.datasourceArray = objects
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: UITableView Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        let object = datasourceArray[indexPath.row]
        cell?.textLabel?.text = object["name"] as? String
        return cell!
    }
}
