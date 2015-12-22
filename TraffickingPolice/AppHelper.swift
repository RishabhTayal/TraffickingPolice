//
//  AppHelper.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/22/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import Parse

class AppHelper: NSObject {
    class func getDisplayLocationFromLocation(geoPoint: PFGeoPoint, completion: (placemark: CLPlacemark) -> Void) {
        let location = CLLocation(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemark: [CLPlacemark]?, error: NSError?) -> Void in
            completion(placemark: placemark![0])
        }
    }
}
