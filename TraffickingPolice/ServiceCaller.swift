//
//  ServiceCaller.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 2/17/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Foundation
import Parse

class ServiceCaller {
    
    class func getReportListing(completion: PFQueryArrayResultBlock) {
        let query = Report.query()
        query?.orderByDescending("createdAt")
        query?.findObjectsInBackgroundWithBlock(completion)
    }
    
    class func updateReportObject(report: Report, completion: PFBooleanResultBlock) {
        report.saveInBackgroundWithBlock(completion)
    }
    
    class func saveReportObject(report: Report, completion: PFBooleanResultBlock) {
        report.saveInBackgroundWithBlock(completion)
    }
}
