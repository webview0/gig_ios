//
//  SubmenuViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class SubmenuViewController : CustomViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint?

    private var menuname = ""
    private var submenu :[HomeMenuItem]?
    private var textColor :UIColor?
    
    // MARK: - View Controller
    
    class func loadFromStoryboard(menuname :String) -> SubmenuViewController?
    {
        let STORYBOARD_ID = "Submenu"
        let vc = AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? SubmenuViewController
        vc?.menuname = menuname
        return vc
    }
    
    class func loadNavigationFromStoryboard() -> UINavigationController?
    {
        let STORYBOARD_ID = "SubmenuNav"
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
        self.tableView?.backgroundColor = self.view.backgroundColor

        // hide empty cells at the end of UITableView
        self.tableView?.tableFooterView = UIView(frame: CGRectZero)

        self.submenu = self.getConfig().getSubmenu(self.menuname)
        
        // set text color same as status bar text color
        if (self.getConfig().getNavigationBarStyle() == .Black) {
            self.textColor = UIColor.lightTextColor()
        } else {
            self.textColor = UIColor.darkTextColor()
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        self.adjustLayouts()
    }
    
    func adjustLayouts()
    {
        let height = CGRectGetHeight(self.view.frame) - 20
        self.constraintImageHeight?.constant = height / 2 - 88
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let arr = self.submenu {
            return arr.count
        }
        return 0
    }
    
    private let CELL_IDENTIFIER = "submenuCell"
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if (CGRectGetHeight(self.view.frame) <= 480) {
            return 44
        }
        return 66
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell :UITableViewCell? = nil
        if let dq = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER) {
            cell = dq
        }
        if let _ = cell {
            // no op
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CELL_IDENTIFIER)
        }
        if let safecell = cell, let item = self.getItemAtIndexPath(indexPath) {
            safecell.textLabel?.text = item.title
            safecell.detailTextLabel?.text = item.subtext
            safecell.textLabel?.textColor = self.textColor
            safecell.detailTextLabel?.textColor = self.textColor
            safecell.backgroundColor = tableView.backgroundColor
            return safecell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Table view data selection
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let menuObj = self.getItemAtIndexPath(indexPath) {
            if ("phone://" == menuObj.url) {
                self.openPhone()
            } else if ("email://" == menuObj.url) {
                self.openEmail()
            } else if ("map://" == menuObj.url) {
                self.openMap()
            } else if ("" != menuObj.url) {
                if (menuObj.external) {
                    if let u = NSURL(string: menuObj.url) {
                        UIApplication.sharedApplication().openURL(u)
                    } else {
                        //BHLog.error("Cannot encode URL: \(menuObj.url)")
                    }
                } else {
                    let vc = WebViewController.loadFromStoryboard(menuObj.url)
                    vc?.title = menuObj.title
                    let back = self.title ?? "Back"
                    BHNavUtil.push(self, destination: vc, backButton: back, animated: true)
                }
            }
        }
    }
    
    func getItemAtIndexPath(indexPath :NSIndexPath) -> HomeMenuItem?
    {
        if let sub = self.submenu {
            let row = indexPath.row
            if (row < sub.count) {
                return sub[row]
            }
        }
        return nil
    }
    
    // MARK: - Helper Functions
    
    func openPhone()
    {
        let phoneNumber = self.getConfig().getPhoneNumber()
        let str = "tel://\(phoneNumber)"
        if let enc = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let url = NSURL(string: enc) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    func openEmail()
    {
        let address = self.getConfig().getEmailAddress()
        let subject = self.getConfig().getEmailSubject()
        let str = "mailto:?to=\(address)&subject=\(subject)"
        if let enc = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            if let url = NSURL(string: enc) {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    func openMap()
    {
        let vc = MapViewController.loadFromStoryboard()
        BHNavUtil.push(self, destination: vc, backButton: "Back", animated: true)
    }
}