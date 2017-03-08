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
    
    private let LOADING_MESSAGE = "Loading"
    private let LOADING_PAUSE   = 10  // amount of time to pause before showing Loading message (in tenths of a second)
    
    private var loadingView    :BHLoadingView? = nil
    private var loadingTimer   :NSTimer?       = nil
    private var loadingCounter :Int = 0
    
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
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(self.shouldHideNavBar(), animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : CustomConfig.handle.getTextColor() ]
        self.navigationController?.navigationBar.barTintColor        = CustomConfig.handle.getBackgroundColor()
        self.navigationController?.navigationBar.tintColor           = CustomConfig.handle.getTextColor()
        self.navigationController?.navigationBar.translucent         = false
        
        let title = self.navigationItem.backBarButtonItem?.title ?? "Back"
        let color = CustomConfig.handle.getTextColor()
        self.navigationItem.leftBarButtonItem = BHBarButtonBack.factory(title, tintColor: color, target: self, action: #selector(WebViewController.pressedBack))
        
        self.loadURL(url: self.url)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    func loadURL(url url :String)
    {
        if let nsurl = NSURL(string: url) {
            self.loadURL(request: NSURLRequest(URL: nsurl))
        } else {
            self.showError("Error: Cannot encode URL")
        }
    }

    func loadURL(request request :NSURLRequest)
    {
        let TLSv12 = "FIX: have sysadmin enable TLS v1.2, then remove NSAppTransportSecurity from Info.plist"
        
        let showLoading = !LinkRouter.willUseInternalMediaPlayer(request)
        if (showLoading) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self.scheduleLoadingView()
        }
        
        self.webViewObj?.loadRequest(LinkRouter.addFreedomHeader(request))
    }
    
    func showError(message :String)
    {
        self.webViewObj?.stopLoading()
        self.webViewObj?.loadHTMLString("<html><body><div>\(message)</div></body></html>", baseURL: nil)
        self.hideLoadingView()
    }
    
    func getHistoryCount() -> Int
    {
        return self.webViewObj?.backForwardList.backList.count ?? 0
    }

    func shouldHideNavBar() -> Bool
    {
        return (CustomConfig.isFullWebApp() && 0 == self.getHistoryCount())
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
    
    // MARK: - Loading View
    
    private func scheduleLoadingView()
    {
        if let _ = self.loadingTimer {
            // if loadingTimer is already set then return
            return
        }
        
        self.loadingCounter = 0
        let SELECTOR_TIMER = #selector(WebViewController.timerCounter)
        if (self.respondsToSelector(SELECTOR_TIMER)) {
            self.loadingTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: SELECTOR_TIMER, userInfo: nil, repeats: true)
            //self.loadingTimer.fire()
        }
    }
    
    func timerCounter()
    {
        self.loadingCounter += 1
        if (self.loadingCounter >= self.LOADING_PAUSE) {
            self.showLoadingView()
        }
    }
    
    private func showLoadingView()
    {
        guard let timer = self.loadingTimer else {
            self.hideLoadingView()
            return
        }
        
        timer.invalidate()
        self.loadingTimer = nil
        
        var rect = self.view.frame
        rect.origin.x = 0
        rect.origin.y = 0
        
        if let v = self.loadingView {
            v.updateRect(rect)
            v.startSpinner()
        } else {
            let v = BHLoadingView(frame: rect)
            self.loadingView = v
            v.setText(self.LOADING_MESSAGE)
            let index = self.view.subviews.count + 99
            self.view.insertSubview(v, atIndex:index)
            v.startSpinner()
        }
    }
    
    private func hideLoadingView()
    {
        if let timer = self.loadingTimer {
            timer.invalidate()
        }
        self.loadingTimer = nil
        if let v = self.loadingView {
            v.stopSpinner()
        }
        self.loadingCounter = 0
    }
}

// MARK: - WebView Delegates

extension WebViewController : WKUIDelegate
{
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation?)
    {
        self.navigationController?.setNavigationBarHidden(self.shouldHideNavBar(), animated: true)

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.hideLoadingView()
    }
}

extension WebViewController : WKNavigationDelegate
{
    // called when user taps a link (and also on initial load)
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void)
    {
        if (navigationAction.navigationType == .LinkActivated) {
            if let url = navigationAction.request.URL, let urlString = url.absoluteString {
                if (LinkRouter.isExternalLink(urlString)) {
                    LinkRouter.openBrowser(url)
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
            self.loadURL(request: navigationAction.request)
        }
        return nil
    }
}
