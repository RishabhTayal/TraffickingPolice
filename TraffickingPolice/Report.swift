//
//  Report.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 2/17/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

class Report {
    
    var reason: String?
    //    var location: CLLocation?
    var abusive: Bool?
    
    init () {
        
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        reason = dict["reason"] as? String
        abusive = dict["abusive"] as? Bool
    }
}
