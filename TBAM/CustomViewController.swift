//
//  CustomViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class CustomViewController : UIViewController
{
    internal var config :CustomConfigProtocol?

    internal func getConfig() -> CustomConfigProtocol
    {
        if let ptr = self.config {
            return ptr
        }
        
        self.config = ConfigFactory.make()
        return self.config!
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return self.getConfig().getPreferredStatusBarStyle()
    }
}