//
//  CustomNavigationController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit


public struct BHDevice
{
    public static func isIPad() -> Bool
    {
        return !BHDevice.isIPhone()
    }

    public static func isIPhone() -> Bool
    {
        return (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
    }
}


class CustomNavigationController : UINavigationController
{
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        if (BHDevice.isIPhone()) {
            return .Portrait
        }
        return .All
    }
}