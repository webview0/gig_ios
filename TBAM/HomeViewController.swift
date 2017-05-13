//
//  HomeViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit
import WebKit

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
    @IBOutlet weak var constraintWebAlertHeight: NSLayoutConstraint?
    @IBOutlet weak var constraintMenuMarginLeading: NSLayoutConstraint?
    @IBOutlet weak var constraintMenuMarginTrailing: NSLayoutConstraint?
    @IBOutlet weak var constraintMenuHeight: NSLayoutConstraint?

    fileprivate var webViewObj :WKWebView?
    fileprivate var menu :[HomeMenuItem]?
    
    // MARK: - View Controller
    
    class func loadFromStoryboard() -> HomeViewController?
    {
        let STORYBOARD_ID = "Home"
        return AppDelegate.storyboard().instantiateViewController(withIdentifier: STORYBOARD_ID) as? HomeViewController
    }
    
    class func loadNavigationFromStoryboard() -> UINavigationController?
    {
        let STORYBOARD_ID = "HomeNav"
        return AppDelegate.storyboard().instantiateViewController(withIdentifier: STORYBOARD_ID) as? UINavigationController
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = CustomConfig.handle.getBackgroundColor()
        
        self.menu = CustomConfig.handle.getHomeMenu()
        
        let alertURL = CustomConfig.handle.getAlertURL()
        if ("" != alertURL) {
            self.webAlertView?.isHidden = false
            self.constraintWebAlertHeight?.constant = 60

            self.webViewObj = WKWebView()
            self.webViewObj!.uiDelegate = self
            self.webViewObj!.navigationDelegate = self
            self.webViewObj!.allowsBackForwardNavigationGestures = false
            self.webViewObj!.scrollView.isScrollEnabled = false
            self.webViewObj!.scrollView.contentInset = UIEdgeInsets.zero
            
            self.webViewObj!.backgroundColor            = UIColor.clear
            self.webViewObj!.scrollView.backgroundColor = UIColor.clear  // have to set the scrollview background color
            self.webAlertView?.backgroundColor          = UIColor.clear
            self.webAlertView?.addSubview(self.webViewObj!)
            
            let dict = [ "child" : self.webViewObj! ]
            self.webViewObj!.translatesAutoresizingMaskIntoConstraints = false
            self.webAlertView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[child]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
            self.webAlertView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[child]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict))
        } else {
            self.webAlertView?.isHidden = true
            self.constraintWebAlertHeight?.constant = 0
        }
        
        if let img = UIImage(named: CustomConfig.handle.getHomeImageName()) {
            self.imgHomeBanner?.contentMode = CustomConfig.handle.getHomeImageAspect()
            self.imgHomeBanner?.image = img
        }

        self.collectionView?.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.fetchAlertContent()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.adjustSubviews()
        self.collectionView?.reloadData()
    }
    
    override func updateViewConstraints()
    {
        super.updateViewConstraints()
        self.adjustSubviews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        self.adjustSubviews()
        self.fetchAlertContent()
        self.collectionView?.reloadData()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.willTransition(to: newCollection, with: coordinator)
        self.adjustSubviews()
        self.collectionView?.reloadData()
    }
    
    func adjustSubviews()
    {
        let width = self.view.frame.width
        //let height = CGRectGetHeight(self.view.frame)

        let numRows    = CGFloat(CustomConfig.handle.getHomeMenuNumRows())
        let numColumns = CGFloat(CustomConfig.handle.getHomeMenuNumColumns())

        let sz = self.getButtonSize()
        self.constraintMenuHeight?.constant = sz * numRows
        
        let padding = max(0, (width - sz * numColumns) / 2)
        self.constraintMenuMarginLeading?.constant  = padding
        self.constraintMenuMarginTrailing?.constant = padding
        
        self.view.layoutIfNeeded()
    }
    
    func getButtonSize() -> CGFloat
    {
        //guard let cv = self.collectionView else { return 0 }

        let numRows    = CGFloat(max(1, CustomConfig.handle.getHomeMenuNumRows()))
        let numColumns = CGFloat(max(1, CustomConfig.handle.getHomeMenuNumColumns()))

        let containerWidth = min(self.view.frame.width, self.view.frame.height * 0.5)
        //let containerHeight = CGRectGetHeight(cv.frame)

        let buttonWidth  = containerWidth / numColumns
        let buttonHeight = containerWidth / numRows
        return min(buttonWidth, buttonHeight)
    }
    
    func fetchAlertContent()
    {
        let alertURL = CustomConfig.handle.getAlertURL()
        if ("" != alertURL) {
            if let nsurl = URL(string: alertURL), let wv = self.webViewObj {
                wv.load(URLRequest(url: nsurl))
            }
        }
    }
}

// MARK: - WebKit Delegates

extension HomeViewController : WKUIDelegate, WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation?)
    {
        //print("finished loading")
    }
    
    // handle target="_blank"
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?
    {
        var flag = false
        if let ptr = navigationAction.targetFrame {
            flag = ptr.isMainFrame
        }
        if (!flag) {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

// MARK: - Collection View Delegates

extension HomeViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let item = self.menuForIndexPath(indexPath) else { return }
        
        var nearestRect = CGRect.zero
        if let attributes = collectionView.layoutAttributesForItem(at: indexPath) {
            let cellRect = attributes.frame
            nearestRect = collectionView.convert(cellRect, to: self.view)
        }
        
        LinkRouter.go(self, nearestRect: nearestRect, menu: item)
    }
}

extension HomeViewController : UICollectionViewDataSource
{
    fileprivate func menuForIndexPath(_ indexPath :IndexPath) -> HomeMenuItem?
    {
        if let mm = self.menu {
            let row = indexPath.row
            if (row < mm.count) {
                return mm[row]
            }
        }
        return nil
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.menu?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cv = self.collectionView else { return UICollectionViewCell() }

        let CELL_IDENTIFIER = "homeMenuCell"
        let cell = cv.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath)
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let sz = self.getButtonSize()
        return CGSize(width: sz, height: sz)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets.zero
    }
}
