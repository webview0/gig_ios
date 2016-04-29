//
//  AppDelegate.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit
//#if TBAM_RELEASE
//import Fabric
//import Crashlytics
//#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        //#if TBAM_RELEASE
        //Fabric.with([Crashlytics.self])
        //#endif
        
        let config = ConfigFactory.make()
        UINavigationBar.appearance().barStyle = config.getNavigationBarStyle()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
    }

    func applicationDidEnterBackground(application: UIApplication)
    {
    }

    func applicationWillEnterForeground(application: UIApplication)
    {
    }

    func applicationDidBecomeActive(application: UIApplication)
    {
    }

    func applicationWillTerminate(application: UIApplication)
    {
    }

    // MARK: - Accessors
    
    class func storyboard() -> UIStoryboard
    {
        let STORYBOARD_NAME = "Main"
        return UIStoryboard(name: STORYBOARD_NAME, bundle: NSBundle.mainBundle())
    }
}
