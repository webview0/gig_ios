//
//  LinkRouter.swift
//  TBAM
//
//  Created by Phill Zarfos on 5/2/16.
//  Copyright © 2016 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class LinkRouter
{
    class func go(fromViewController :UIViewController, menu :HomeMenuItem?)
    {
        guard let menu = menu else { return }
        
        if ("" == menu.url) {
            return
        }
        
        if ("phone://" == menu.url) {
            LinkRouter.openPhone(CustomConfig.handle.getPhoneNumber())
            return
        } else if ("email://" == menu.url) {
            LinkRouter.openEmail(CustomConfig.handle.getEmailAddress(), subject: CustomConfig.handle.getEmailSubject())
            return
        } else if ("map://" == menu.url) {
            LinkRouter.openMap(fromViewController)
            return
        }

        var vc :UIViewController? = nil
        if ("submenu://contact" == menu.url) {
            vc = SubmenuViewController.loadFromStoryboard(menu.url)
        } else {
            if (CustomConfig.handle.isExternalLink(menu.url)) {
                if let u = NSURL(string: menu.url) {
                    LinkRouter.openSafari(u)
                }
                return
            } else {
                vc = WebViewController.loadFromStoryboard(menu.url)
            }
        }
        
        guard let safeVC = vc else { return }
        safeVC.title = menu.title
        fromViewController.navigationController?.pushViewController(safeVC, animated: true)
    }
    
    class func openSafari(url :NSURL) -> Bool
    {
        let app = UIApplication.sharedApplication()
        if (app.canOpenURL(url)) {
            return app.openURL(url)
        }
        return false
    }
    
    class func openPhone(phoneNumber :String)
    {
        let str = "tel://\(phoneNumber)"
        if let enc = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let url = NSURL(string: enc) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    class func openEmail(to :String, subject :String)
    {
        let str = "mailto:?to=\(to)&subject=\(subject)"
        if let enc = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let url = NSURL(string: enc) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    class func openMap(fromViewController :UIViewController)
    {
        if let vc = MapViewController.loadFromStoryboard() {
            fromViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
