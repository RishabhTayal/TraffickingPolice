//
//  Report.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 2/17/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Foundation
import Parse

protocol PropertyNames {
    func propertyNames() -> [String]
}

class Report: PFObject, PFSubclassing, PropertyNames {
    
    @NSManaged var reason: String?
    @NSManaged var location: PFGeoPoint?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var imageUrl1: NSString?
    @NSManaged var imageUrl2: NSString?
    @NSManaged var abusive: Bool

    static func parseClassName() -> String {
        return "Report"
    }
    
    override init() {
        super.init()
    }
    
    init(dict: Dictionary<String, AnyObject>) {
        super.init()
        reason = dict["reason"] as? String
        latitude = dict["latitude"] as? NSNumber
        longitude = dict["longitude"] as? NSNumber
        imageUrl1 = dict["imageUrl1"] as? String
        imageUrl2 = dict["imageUrl2"] as? String
        abusive = dict["abusive"] as! Bool
    }
}

extension PropertyNames {
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
}