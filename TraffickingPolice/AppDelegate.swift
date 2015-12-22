//
//  AppDelegate.swift
//  TraffickingPolice
//
//  Created by Tayal, Rishabh on 12/21/15.
//  Copyright © 2015 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Fabric.with([Crashlytics.self])

        Parse.setApplicationId("rPbZtCbRv7QiEubmB5mm4PkWrsEPNZ2ECxVQMUBT",
            clientKey: "AfNkj8eXEaUn0Tqqx8i6jVuLirHN5aqEuUVBBtat")
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)

        if PFUser.currentUser() == nil {
            showLoginScreen()
        } else {
            showMainScreen()
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    func showLoginScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
    
    func showMainScreen() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("ReportViewController") as! ReportViewController
        let nav1 = UINavigationController(rootViewController: vc)
        
        let vc2 = sb.instantiateViewControllerWithIdentifier("ReportedViewController") as! ReportedViewController
        vc2.title = "Reported"
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let vc3 = sb.instantiateViewControllerWithIdentifier("InstructionsViewController") as! InstructionsViewController
        vc3.title = "Instructions"
        let nav3 = UINavigationController(rootViewController: vc3)
        
        let tab: UITabBarController = UITabBarController()
        tab.viewControllers = [nav1, nav2, nav3]
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
    }
}
