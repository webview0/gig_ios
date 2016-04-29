//
//  HomeViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit
import WebKit


class BHNavUtil
{
    class func push(originalViewController :UIViewController, destination :UIViewController?, backButton: String, animated :Bool) -> Bool
    {
        guard let vc = destination else { return false }
        
        originalViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: backButton, style: .Plain, target: nil, action: nil)
        originalViewController.navigationController?.pushViewController(vc, animated: animated)
        return true
    }
}


//
// WKWebView tips
// http://atmarkplant.com/ios-wkwebview-tips/
//

class HomeViewController : CustomViewController
{
    @IBOutlet weak var imgHomeBanner: UIImageView?
    @IBOutlet weak var webAlertView: UIView?
    @IBOutlet weak var collectionView: UICollectionView?
//    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint?
    @IBOutlet weak var constraintMenuMarginLeading: NSLayoutConstraint?
    @IBOutlet weak var constraintMenuMarginTrailing: NSLayoutConstraint?
    @IBOutlet weak var constraintMenuHeight: NSLayoutConstraint?

    private var webViewObj :WKWebView?
    private var menu :[HomeMenuItem]?
    
    // MARK: - View Controller
    
    class func loadFromStoryboard() -> HomeViewController?
    {
        let STORYBOARD_ID = "Home"
        return AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? HomeViewController
    }
    
    class func loadNavigationFromStoryboard() -> UINavigationController?
    {
        let STORYBOARD_ID = "HomeNav"
        return AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? UINavigationController
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.getConfig().getBackgroundColor()
        
        self.menu = self.getConfig().getHomeMenu()
        
        let alertURL = self.getConfig().getAlertURL()
        if ("" != alertURL) {
            self.webAlertView?.hidden = false
            self.webViewObj = WKWebView()
            self.webViewObj!.UIDelegate = self
            self.webViewObj!.navigationDelegate = self
            self.webViewObj!.allowsBackForwardNavigationGestures = false
            self.webViewObj!.scrollView.scrollEnabled = false
            self.webViewObj!.scrollView.contentInset = UIEdgeInsetsZero
            
            self.webViewObj!.backgroundColor            = UIColor.clearColor()
            self.webViewObj!.scrollView.backgroundColor = UIColor.clearColor()  // have to set the scrollview background color
            self.webAlertView?.backgroundColor          = UIColor.clearColor()
            self.webAlertView?.addSubview(self.webViewObj!)
            
            let dict = [ "child" : self.webViewObj! ]
            self.webViewObj!.translatesAutoresizingMaskIntoConstraints = false
            self.webAlertView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[child]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
            self.webAlertView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[child]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        } else {
            self.webAlertView?.hidden = true
        }
        
        if let img = UIImage(named: self.getConfig().getHomeImageName()) {
            self.imgHomeBanner?.contentMode = self.getConfig().getHomeImageAspect()
            self.imgHomeBanner?.image = img
        }

        self.collectionView?.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.fetchAlertContent()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.adjustSubviews()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        self.adjustSubviews()
    }
    
    override func updateViewConstraints()
    {
        super.updateViewConstraints()
        self.adjustSubviews()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.adjustSubviews()
        self.fetchAlertContent()
        self.collectionView?.reloadData()
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        self.adjustSubviews()
        self.collectionView?.reloadData()
    }
    
    func adjustSubviews()
    {
        let width = CGRectGetWidth(self.view.frame)
        //let height = CGRectGetHeight(self.view.frame)

        let numRows    = CGFloat(self.getConfig().getHomeMenuNumRows())
        let numColumns = CGFloat(self.getConfig().getHomeMenuNumColumns())

        let sz = self.getButtonSize()
        self.constraintMenuHeight?.constant = sz * numRows
        
        let padding = max(0, (width - sz * numColumns) / 2)
        self.constraintMenuMarginLeading?.constant  = padding
        self.constraintMenuMarginTrailing?.constant = padding
    }
    
    func getButtonSize() -> CGFloat
    {
        //guard let cv = self.collectionView else { return 0 }

        let numRows    = CGFloat(max(1, self.getConfig().getHomeMenuNumRows()))
        let numColumns = CGFloat(max(1, self.getConfig().getHomeMenuNumColumns()))

        let containerWidth = min(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))
        //let containerHeight = CGRectGetHeight(cv.frame)

        let buttonWidth  = containerWidth / numColumns
        let buttonHeight = containerWidth / numRows
        return min(buttonWidth, buttonHeight)
    }
    
    func fetchAlertContent()
    {
        let alertURL = self.getConfig().getAlertURL()
        if ("" != alertURL) {
            if let nsurl = NSURL(string: alertURL), let wv = self.webViewObj {
                //NSLog("Loading alert \(alertURL)")
                wv.loadRequest(NSURLRequest(URL: nsurl))
            }
        }
    }
}

// MARK: - WebKit Delegates

extension HomeViewController : WKUIDelegate, WKNavigationDelegate
{
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation?)
    {
        //NSLog("finished loading alert")
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

// MARK: - Collection View Delegates

extension HomeViewController : UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if let menuObj = self.menuForIndexPath(indexPath) {
            var vc :UIViewController? = nil
            if ("submenu://contact" == menuObj.url) {
                vc = SubmenuViewController.loadFromStoryboard(menuObj.url)
            } else if ("" != menuObj.url) {
                if (menuObj.external) {
                    if let u = NSURL(string: menuObj.url) {
                        UIApplication.sharedApplication().openURL(u)
                    } else {
                        //BHLog.error("Cannot encode URL: \(menuObj.url)")
                    }
                    return
                } else {
                    vc = WebViewController.loadFromStoryboard(menuObj.url)
                }
            }
            vc?.title = menuObj.title
            BHNavUtil.push(self, destination: vc, backButton: "Home", animated: true)
        }
    }
}

extension HomeViewController : UICollectionViewDataSource
{
    private func menuForIndexPath(indexPath :NSIndexPath) -> HomeMenuItem?
    {
        if let mm = self.menu {
            let row = indexPath.row
            if (row < mm.count) {
                return mm[row]
            }
        }
        return nil
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.menu?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        guard let cv = self.collectionView else { return UICollectionViewCell() }

        let CELL_IDENTIFIER = "homeMenuCell"
        let cell = cv.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath: indexPath)
        if let menuCell = cell as? HomeMenuCollectionViewCell, let menuObj = self.menuForIndexPath(indexPath) {
            if let icon = UIImage(named: menuObj.icon) {
                menuCell.imgIcon?.image = icon
            }
        }
        return cell
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let sz = self.getButtonSize()
        return CGSize(width: sz, height: sz)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsZero
    }
}
