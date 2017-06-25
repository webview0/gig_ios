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
    class func go(_ fromViewController :UIViewController, nearestRect :CGRect, menu :HomeMenuItem?)
    {
        guard let menu = menu else { return }
        
        if ("" == menu.url) {
            return
        }
        
        BHLog.info { "LinkRouter.go: \(menu.url))" }

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
            if let nsurl = URL(string: menu.url) {
                let _ = LinkRouter.openBrowser(nsurl)
            }
            return
        }
        
        if let vc = WebViewController.loadFromStoryboard(menu.url) {
            vc.title = menu.title
            fromViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    class func openSubmenu(_ fromViewController :UIViewController, nearestRect :CGRect, name :String)
    {
        let submenu = CustomConfig.handle.getSubmenu(name)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in submenu {
            let action = UIAlertAction(title: item.title, style: .default) {
                [weak fromViewController]
                _ in
                if let vc = fromViewController {
                    LinkRouter.go(vc, nearestRect: nearestRect, menu: item)
                }
            }
            alert.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel) { _ in }
        alert.addAction(cancel)

        if let popoverController = alert.popoverPresentationController {
            // make sure we have an actual view to attach to (iPads will crash if they don't have a valid popover view)
            popoverController.sourceView = fromViewController.view
            popoverController.sourceRect = nearestRect
        }
        
        fromViewController.present(alert, animated: true) { }
    }

    class func openBrowser(_ url :URL) -> Bool
    {
        let app = UIApplication.shared
        if (app.canOpenURL(url)) {
            return app.openURL(url)
        }
        return false
    }
    
    class func openPhone(_ phoneNumber :String)
    {
        let str = "tel://\(phoneNumber)"
        if let enc = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let nsurl = URL(string: enc) {
                UIApplication.shared.openURL(nsurl)
            }
        }
    }
    
    class func openEmail(_ to :String, subject :String)
    {
        let str = "mailto:?to=\(to)&subject=\(subject)"
        if let enc = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let nsurl = URL(string: enc) {
                UIApplication.shared.openURL(nsurl)
            }
        }
    }
    
    class func openMap(_ fromViewController :UIViewController)
    {
        if let vc = MapViewController.loadFromStoryboard() {
            vc.title = "Map"
            fromViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LinkRouter
{
    class func isExternalLink(_ url :String) -> Bool
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
    
    class func willUseInternalMediaPlayer(_ request :URLRequest) -> Bool
    {
        if let ext = request.url?.pathExtension {
            if ("mp3" == ext.lowercased()) {
                return true
            }
        }
        return false
    }
    
    class func addFreedomHeader(_ request :URLRequest) -> URLRequest
    {
        let mutable = (request as NSURLRequest).mutableCopy()
        (mutable as AnyObject).addValue("1", forHTTPHeaderField: "X-Freedom-Mobile")
        return mutable as! URLRequest
    }
}
