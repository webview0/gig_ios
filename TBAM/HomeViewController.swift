//
//  HomeViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit


class BHNavUtil
{
    class func push(originalViewController :UIViewController, destination :UIViewController?, backButton: String, animated :Bool) -> Bool
    {
        guard let vc = destination else { return false }
        
        originalViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: backButton, style: .Plain, target: nil, action: nil)
        originalViewController.navigationController?.pushViewController(vc, animated: animated)
        return true
    }
    
    class func pop(viewController :UIViewController, animated :Bool) -> Bool
    {
        guard let navController = viewController.navigationController else { return false }
        
        navController.popViewControllerAnimated(animated)
        return true
    }
    
    class func present(originalViewController :UIViewController, destination :UIViewController?, animated :Bool) -> Bool
    {
        guard let vc = destination else { return false }
        
        originalViewController.presentViewController(vc, animated: animated, completion: nil)
        return true
    }
    
    class func dismiss(viewController :UIViewController, animated :Bool)
    {
        viewController.dismissViewControllerAnimated(animated, completion: nil)
    }
    
    class func replace(originalViewController :UIViewController, destination :UIViewController?) -> Bool
    {
        guard let vc = destination else { return false }
        
        originalViewController.view.window?.rootViewController = vc
        return true
    }
}


//
// WKWebView tips
// http://atmarkplant.com/ios-wkwebview-tips/
//

class HomeViewController : CustomViewController
{
    @IBOutlet weak var imgHomeBanner: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint!
    
    private let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private var menu :[HomeMenuItem]!
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem?.title = "Done"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.getConfig().getBackgroundColor()
        
        self.menu = self.getConfig().getHomeMenu()

        // set nav bar
        self.title = "Home"
        let SELECTOR_DONE = Selector("pressedDone:")
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: SELECTOR_DONE)
        //        let SELECTOR_DONE = Selector("")
        //        if (self.respondsToSelector(SELECTOR_DONE)) {
        //            btnDone.action = SELECTOR_DONE
        //        }
        self.navigationItem.leftBarButtonItem = btnDone
        
        self.collectionView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        self.adjustLayouts()
    }
    
    func adjustLayouts()
    {
        let height = CGRectGetHeight(self.view.frame) - 20
        self.constraintImageHeight.constant = height / 2
    }
}

// MARK: - Delegates

extension HomeViewController : UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if let menuObj = self.menuForIndexPath(indexPath) {
            if ("submenu://contact" == menuObj.url) {
                let vc = SubmenuViewController.loadFromStoryboard(menuObj.url)
                BHNavUtil.push(self, destination: vc, backButton: "Home", animated: true)
            } else if ("" != menuObj.url) {
                let vc = WebViewController.loadFromStoryboard(menuObj.url)
                BHNavUtil.push(self, destination: vc, backButton: menuObj.title, animated: true)
            }
        }
    }
}

extension HomeViewController : UICollectionViewDataSource
{
    private func menuForIndexPath(indexPath :NSIndexPath) -> HomeMenuItem?
    {
        let row = indexPath.row
        if (row < self.menu.count) {
            return self.menu[row]
        }
        return nil
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.menu.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let CELL_IDENTIFIER = "homeMenuCell"
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(CELL_IDENTIFIER, forIndexPath: indexPath)
        if let menuCell = cell as? HomeMenuCollectionViewCell, let menuObj = self.menuForIndexPath(indexPath) {
            if let icon = UIImage(named: menuObj.icon) {
                menuCell.imgIcon.image = icon
            }
        }
        return cell
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let w = CGRectGetWidth(self.collectionView.frame)
        let h = CGRectGetHeight(self.collectionView.frame)
        let buttonWidth  = w / 4 - 20
        let buttonHeight = (h - 20) / 3
        let sz = min(buttonWidth, buttonHeight)
        return CGSize(width: sz, height: sz)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return sectionInsets
    }
}
