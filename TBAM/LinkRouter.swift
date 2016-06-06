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
    class func go(fromViewController :UIViewController, nearestRect :CGRect, menu :HomeMenuItem?)
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

        if ("submenu://contact" == menu.url) {
            LinkRouter.openSubmenu(fromViewController, nearestRect: nearestRect, name: menu.url)
            return
        }

        if (LinkRouter.isExternalLink(menu.url)) {
            if let nsurl = NSURL(string: menu.url) {
                LinkRouter.openBrowser(nsurl)
            }
            return
        }
        
        if let vc = WebViewController.loadFromStoryboard(menu.url) {
            vc.title = menu.title
            fromViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    class func openSubmenu(fromViewController :UIViewController, nearestRect :CGRect, name :String)
    {
        let submenu = CustomConfig.handle.getSubmenu(name)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        for item in submenu {
            let action = UIAlertAction(title: item.title, style: .Default) {
                [weak fromViewController]
                _ in
                if let vc = fromViewController {
                    LinkRouter.go(vc, nearestRect: nearestRect, menu: item)
                }
            }
            alert.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { _ in }
        alert.addAction(cancel)

        if let popoverController = alert.popoverPresentationController {
            // make sure we have an actual view to attach to (iPads will crash if they don't have a valid popover view)
            popoverController.sourceView = fromViewController.view
            popoverController.sourceRect = nearestRect
        }
        
        fromViewController.presentViewController(alert, animated: true) { }
    }

    class func openBrowser(url :NSURL) -> Bool
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
            if let nsurl = NSURL(string: enc) {
                UIApplication.sharedApplication().openURL(nsurl)
            }
        }
    }
    
    class func openEmail(to :String, subject :String)
    {
        let str = "mailto:?to=\(to)&subject=\(subject)"
        if let enc = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let nsurl = NSURL(string: enc) {
                UIApplication.sharedApplication().openURL(nsurl)
            }
        }
    }
    
    class func openMap(fromViewController :UIViewController)
    {
        if let vc = MapViewController.loadFromStoryboard() {
            vc.title = "Map"
            fromViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LinkRouter
{
    class func isExternalLink(url :String) -> Bool
    {
        // blacklist
        let externalList = CustomConfig.handle.getExternalLinks()
        for extURL in externalList {
            if (url.hasPrefix(extURL)) {
                return true
            }
        }
        
        // whitelist
        let internalList = CustomConfig.handle.getInternalDomains()
        for domain in internalList {
            if (url.hasPrefix("http://\(domain)") || url.hasPrefix("https://\(domain)")) {
                return false
            }
        }
        
        // all other links will be external
        return true
    }
    
    class func willUseInternalMediaPlayer(request :NSURLRequest) -> Bool
    {
        if let url = request.URL {
            let str = url.absoluteString.lowercaseString
            if (str.hasSuffix("mp3")) {
                return true
            }
        }
        return false
    }
}
