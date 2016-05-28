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
    
    typealias Completion = ((result: AnyObject?, error: NSError?) -> Void)
    
    class func getReportListing(completion: Completion) {
//        makeAPICall("/reports", completion: completion)
    }
    
    class func updateReportObject(report: Report, completion: Completion) {
        completion(result: nil, error: nil)
    }
    
    class func saveReportObject(report: Report, completion: Completion) {
        report.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            completion(result: nil, error: nil)
        }
    }
    
//    private class func makeAPICall(endpoint: String, completion: Completion) {
//        let baseUrl = "https://trafficking-backend.herokuapp.com/parse"
//        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl + endpoint)!)
//        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
//        session.dataTaskWithRequest(request) { (d: NSData?, r: NSURLResponse?, e: NSError?) -> Void in
//            if let data = d {
//                do {
//                    let result = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        completion(result: result, error: nil)
//                    })
//                } catch {
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        completion(result: nil, error: nil)
//                    })
//                }
//            } else {
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    completion(result: nil, error: e)
//                })
//            }
//        }.resume()
//    }
}
