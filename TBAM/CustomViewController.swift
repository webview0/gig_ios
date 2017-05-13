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
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return CustomConfig.handle.getStatusBarStyle()
    }
}
