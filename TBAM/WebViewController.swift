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

class WebViewController : CustomViewController
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.webViewObj = WKWebView()
        self.webViewObj!.UIDelegate = self
        self.webViewObj!.navigationDelegate = self
        self.webViewObj!.backgroundColor = CustomConfig.handle.getBackgroundColor()
        self.webViewObj!.scrollView.backgroundColor = CustomConfig.handle.getBackgroundColor()  // have to set the scrollview background color
        self.webViewObj!.allowsBackForwardNavigationGestures = true
        self.view = self.webViewObj!
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.loadURL(self.url)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : CustomConfig.handle.getTextColor() ]
        self.navigationController?.navigationBar.barTintColor        = CustomConfig.handle.getBackgroundColor()
        self.navigationController?.navigationBar.tintColor           = CustomConfig.handle.getTextColor()
        self.navigationController?.navigationBar.translucent         = false
        
        let title = self.navigationItem.backBarButtonItem?.title ?? "Back"
        let btn = UIBarButtonItem(title: title, style: .Plain, target: self, action: #selector(WebViewController.pressedBack))
        self.navigationItem.leftBarButtonItem = btn
    }
    
    func loadURL(url :String)
    {
        if false { "FIX: have sysadmin enable TLS v1.2, then remove NSAppTransportSecurity from Info.plist" }
        
        if let nsurl = NSURL(string: url) {
            self.webViewObj?.loadRequest(NSURLRequest(URL: nsurl))
        } else {
            self.showError("Error: Cannot encode URL")
        }
    }
    
    func showError(message :String)
    {
        self.webViewObj?.stopLoading()
        self.webViewObj?.loadHTMLString("<html><body><div>\(message)</div></body></html>", baseURL: nil)
    }

    // MARK: - Shake Gesture
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?)
    {
        // goto Home screen if they shake the device
        if (motion == .MotionShake) {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: - Actions
    
    func pressedBack()
    {
        if let wv = self.webViewObj {
            if (wv.canGoBack) {
                wv.goBack()
                return
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: - WebView Delegates

extension WebViewController : WKUIDelegate
{
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation?)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

extension WebViewController : WKNavigationDelegate
{
    // called when user taps a link (and also on initial load)
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void)
    {
        if (navigationAction.navigationType == .LinkActivated) {
            if let url = navigationAction.request.URL {
                if (CustomConfig.handle.isExternalLink(url.absoluteString)) {
                    LinkRouter.openSafari(url)
                    decisionHandler(WKNavigationActionPolicy.Cancel)
                    return
                }
            }
        }
        
        decisionHandler(WKNavigationActionPolicy.Allow)
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
