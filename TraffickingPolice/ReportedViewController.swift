//
//  ReportedViewController.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import UITableView_NXEmptyView
import AFNetworking

class ReportedViewController: UIViewController {
    
    var tableView: UITableView!
    var datasourceArray: [PFObject] = []
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reported"
        
        tableView = UITableView(frame: self.view.frame, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.registerNib(UINib(nibName: "ReportedTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64
        
        refreshData()
    }
    
    func refreshData() {
        let query = PFQuery(className: "Reported")
        query.orderByDescending("createdAt")
        //        query.whereKey("owner", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            self.refreshControl.endRefreshing()
            if let objects = objects {
                self.datasourceArray = objects
                self.tableView.reloadData()
            }
            self.tableView.nxEV_emptyView = UIView.emptyViewWithLabel(self.tableView.frame, text: "No reports submitted")
            self.tableView.nxEV_hideSeparatorLinesWhenShowingEmptyView = true
        }
    }
}

extension ReportedViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: UITableView Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasourceArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ReportedTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! ReportedTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        let object = datasourceArray[indexPath.row]
        cell.nameLabel.text = object["reason"] as? String
        let location = object["location"] as? PFGeoPoint
        AppHelper.getDisplayLocationFromLocation(location) { (locationString) -> Void in
            cell.subTitleLabel.text = locationString
        }
        if let file = object["image"] as? PFFile {
            cell.mainImageView.setImageWithURL(NSURL(string: file.url!)!)
        } else {
            cell.mainImageView.image = UIImage(named: "default_avatar")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ReportedDetailViewController") as! ReportedDetailViewController
        vc.form.disabled = true
        vc.reportObject = datasourceArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
