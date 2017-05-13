//
//  AppDelegate.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        #if BHAPPANALYZER_ANSWERS
        Fabric.with([Crashlytics.self])
        #endif
        #if DEBUG
        print("Crashlytics v\(Crashlytics.sharedInstance().version)")
        #endif

        UINavigationBar.appearance().barStyle = CustomConfig.handle.getNavigationBarStyle()
        
        if (CustomConfig.isFullWebApp()) {
            let url = CustomConfig.handle.getWebAppURL()
            let vc  = WebViewController.loadFromStoryboard(url)
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
    }

    // MARK: - Accessors
    
    class func storyboard() -> UIStoryboard
    {
        let STORYBOARD_NAME = "Main"
        return UIStoryboard(name: STORYBOARD_NAME, bundle: Bundle.main)
    }
}
