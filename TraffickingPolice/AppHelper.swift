//
//  AppHelper.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/22/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

//import Parse
import UIKit
import CoreLocation

class AppHelper: NSObject {
    class func getDisplayLocationFromLocation(geoPoint: PFGeoPoint?, completion: (locationString: String) -> Void) {
        if let geoPoint = geoPoint {
            let location = CLLocation(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) { (placemark: [CLPlacemark]?, error: NSError?) -> Void in
                if let firstPlacemark = placemark!.first {
                    var str = ""
                    if let locality = firstPlacemark.locality {
                        str = locality
                    }
                    if let administrativeArea = firstPlacemark.administrativeArea {
                        str = str + ", " + administrativeArea
                    }
                    if str == "" {
                        completion(locationString: "Location added")
                    } else {
                        completion(locationString: str)
                    }
                } else {
                    completion(locationString: "")
                }
            }
        } else {
            completion(locationString: "")
        }
    }
}

extension UIView {
    func roundView() {
        self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2
    }

    class func emptyViewWithLabel(frame: CGRect, text: String) -> UIView {
        let label = UILabel(frame: frame)
        label.textColor = UIColor.lightGrayColor()
        label.textAlignment = .Center
        label.text = text
        return label
    }
}
