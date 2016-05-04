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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = CustomConfig.handle.getBackgroundColor()
        self.tableView?.backgroundColor = self.view.backgroundColor

        // hide empty cells at the end of UITableView
        self.tableView?.tableFooterView = UIView(frame: CGRectZero)

        self.submenu = CustomConfig.handle.getSubmenu(self.menuname)
        
        // set text color same as status bar text color
        if (CustomConfig.handle.getNavigationBarStyle() == .Black) {
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
        guard let item = self.getItemAtIndexPath(indexPath) else { return }
        LinkRouter.go(self, menu: item)
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
    

}