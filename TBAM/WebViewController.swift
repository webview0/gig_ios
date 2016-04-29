//
//  WebViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit
import WebKit

// TODO: add loading view spinner
// TODO: add pull-to-refresh
// TODO: add custom local caching

class WebViewController : CustomViewController, WKUIDelegate, WKNavigationDelegate
{
    private var webViewObj :WKWebView?
    
    private var url = ""
    
    // MARK: - View Controller
    
    class func loadFromStoryboard(url :String) -> WebViewController?
    {
        let STORYBOARD_ID = "Web"
        let vc = AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? WebViewController
        vc?.url = url
        return vc
    }
    
    class func loadNavigationFromStoryboard() -> UINavigationController?
    {
        let STORYBOARD_ID = "WebNav"
        return AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? UINavigationController
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        self.navigationItem.title = "Photos"
        self.navigationItem.backBarButtonItem?.title = "Done"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.webViewObj = WKWebView()
        self.webViewObj!.UIDelegate = self
        self.webViewObj!.navigationDelegate = self
        self.webViewObj!.backgroundColor = self.getConfig().getBackgroundColor()
        self.webViewObj!.scrollView.backgroundColor = self.getConfig().getBackgroundColor()  // have to set the scrollview background color
        self.view = self.webViewObj!
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        if false { "FIX: have sysadmin enable TLS v1.2, then remove NSAppTransportSecurity from Info.plist" }
        
        if let nsurl = NSURL(string: self.url) {
            //NSLog("Loading page \(self.url)")
            self.webViewObj!.loadRequest(NSURLRequest(URL: nsurl))
            self.webViewObj!.allowsBackForwardNavigationGestures = true
        } else {
            //NSLog("Cannot encode URL")
            // TODO: show error message on page
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : self.getConfig().getTextColor() ]
        self.navigationController?.navigationBar.barTintColor        = self.getConfig().getBackgroundColor()
        self.navigationController?.navigationBar.tintColor           = self.getConfig().getTextColor()
        self.navigationController?.navigationBar.translucent         = false
    }
    
    // MARK: - WebView Delegates
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation?)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // handle target="_blank"
    func webView(webView: WKWebView, createWebViewWithConfiguration configuration: WKWebViewConfiguration, forNavigationAction navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?
    {
        var flag = false
        if let ptr = navigationAction.targetFrame {
            flag = ptr.mainFrame
        }
        if (!flag) {
            webView.loadRequest(navigationAction.request)
        }
        return nil
    }
}
