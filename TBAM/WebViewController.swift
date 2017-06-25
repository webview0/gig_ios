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
    fileprivate var webViewObj :WKWebView?

    fileprivate var url = ""
    
    fileprivate let LOADING_MESSAGE = "Loading"
    fileprivate let LOADING_PAUSE   = 10  // amount of time to pause before showing Loading message (in tenths of a second)
    
    fileprivate var loadingView    :BHLoadingView? = nil
    fileprivate var loadingTimer   :Timer?         = nil
    fileprivate var loadingCounter :Int            = 0
    
    // MARK: - View Controller
    
    class func loadFromStoryboard(_ url :String) -> WebViewController?
    {
        let STORYBOARD_ID = "Web"
        let vc = AppDelegate.storyboard().instantiateViewController(withIdentifier: STORYBOARD_ID) as? WebViewController
        vc?.url = url
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.webViewObj = WKWebView()
        self.webViewObj!.uiDelegate                          = self
        self.webViewObj!.navigationDelegate                  = self
        self.webViewObj!.backgroundColor                     = CustomConfig.handle.getBackgroundColor()
        self.webViewObj!.scrollView.backgroundColor          = CustomConfig.handle.getBackgroundColor()  // have to set the scrollview background color
        self.webViewObj!.allowsBackForwardNavigationGestures = true
        self.view = self.webViewObj!
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(self.shouldHideNavBar(), animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : CustomConfig.handle.getTextColor() ]
        self.navigationController?.navigationBar.barTintColor        = CustomConfig.handle.getBackgroundColor()
        self.navigationController?.navigationBar.tintColor           = CustomConfig.handle.getTextColor()
        self.navigationController?.navigationBar.isTranslucent       = false
        
        let title = self.navigationItem.backBarButtonItem?.title ?? "Back"
        let color = CustomConfig.handle.getTextColor()
        self.navigationItem.leftBarButtonItem = BHBarButtonBack.factory(title, tintColor: color, target: self, action: #selector(WebViewController.pressedBack))
        
        self.loadURL(url: self.url)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    func loadURL(url :String)
    {
        if let nsurl = URL(string: url) {
            self.loadURL(request: URLRequest(url: nsurl))
        } else {
            self.showError("Error: Cannot encode URL")
        }
    }

    func loadURL(request :URLRequest)
    {
        BHLog.debug { "WebViewController.loadURL: \(String(describing: request.url?.absoluteString))" }
        
        let TLSv12 = "FIX: have sysadmin enable TLS v1.2, then remove NSAppTransportSecurity from Info.plist"
        
        let showLoading = !LinkRouter.willUseInternalMediaPlayer(request)
        if (showLoading) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.scheduleLoadingView()
        }
        
        self.webViewObj?.load(LinkRouter.addFreedomHeader(request))
    }
    
    func showError(_ message :String)
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
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        // goto Home screen if they shake the device
        if (motion == .motionShake) {
            self.navigationController?.popViewController(animated: true)
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
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Loading View
    
    fileprivate func scheduleLoadingView()
    {
        if let _ = self.loadingTimer {
            // if loadingTimer is already set then return
            return
        }
        
        self.loadingCounter = 0
        let SELECTOR_TIMER = #selector(WebViewController.timerCounter)
        if (self.responds(to: SELECTOR_TIMER)) {
            self.loadingTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: SELECTOR_TIMER, userInfo: nil, repeats: true)
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
    
    fileprivate func showLoadingView()
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
            self.view.insertSubview(v, at: index)
            v.startSpinner()
        }
    }
    
    fileprivate func hideLoadingView()
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
    func webView(_ webView :WKWebView, didFinish navigation :WKNavigation?)
    {
        self.navigationController?.setNavigationBarHidden(self.shouldHideNavBar(), animated: true)

        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.hideLoadingView()
    }
}

extension WebViewController : WKNavigationDelegate
{
    // called when user taps a link (and also on initial load)
    func webView(_ webView :WKWebView, decidePolicyFor navigationAction :WKNavigationAction, decisionHandler :@escaping (WKNavigationActionPolicy) -> Void)
    {
        BHLog.debug { "WebViewController.decidePolicyFor: navigationAction.navigationType: \(navigationAction.navigationType.rawValue))" }
        BHLog.debug { "WebViewController.decidePolicyFor: url: \(url))" }
        
        if (navigationAction.navigationType == .linkActivated) {
            if let url = navigationAction.request.url {
                if (LinkRouter.isExternalLink(url.absoluteString)) {
                    let _ = LinkRouter.openBrowser(url)
                    decisionHandler(WKNavigationActionPolicy.cancel)
                    return
                }
            }
        }
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation?)
    {
        BHLog.debug { "WebViewController.didStartProvisionalNavigation" }
    }

    // handle target="_blank"
    func webView(_ webView :WKWebView, createWebViewWith configuration :WKWebViewConfiguration, for navigationAction :WKNavigationAction, windowFeatures :WKWindowFeatures) -> WKWebView?
    {
        var flag = false
        if let ptr = navigationAction.targetFrame {
            flag = ptr.isMainFrame
        }
        if (!flag) {
            self.loadURL(request: navigationAction.request)
        }
        return nil
    }
}
