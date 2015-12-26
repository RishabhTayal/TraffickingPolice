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
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reported"
        
        tableView = UITableView(frame: self.view.frame, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        refreshData()
    }
    
    func refreshData() {
        let query = PFQuery(className: "Reported")
        query.orderByDescending("createdAt")
        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            self.refreshControl.endRefreshing()
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
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        let object = datasourceArray[indexPath.row]
        cell?.textLabel?.text = object["name"] as? String
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ReportedDetailViewController") as! ReportedDetailViewController
        vc.form.disabled = true
        vc.reportObject = datasourceArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
