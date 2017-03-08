//
//  CustomConfigProtocol.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

// Lat-Lon lookup
// http://www.latlong.net/convert-address-to-lat-long.html

protocol CustomConfigProtocol
{
    func getBackgroundColor()         -> UIColor
    func getStatusBarStyle()          -> UIStatusBarStyle
    func getNavigationBarStyle()      -> UIBarStyle
    func getHomeImageName()           -> String
    func getHomeImageAspect()         -> UIViewContentMode
    func getTextFont()                -> UIFont
    func getTextColor()               -> UIColor
    func getWebAppURL()               -> String
    func getAlertURL()                -> String
    func getHomeMenuNumRows()         -> Int
    func getHomeMenuNumColumns()      -> Int
    func getHomeMenu()                -> [HomeMenuItem]
    func getSubmenu(name :String)     -> [HomeMenuItem]
    func getInternalDomains()         -> [String]
    func getExternalLinks()           -> [String]
    func getTitle()                   -> String
    func getPhysicalAddress()         -> String
    func getLocationLatitude()        -> Double
    func getLocationLongitude()       -> Double
    func getPhoneNumber()             -> String
    func getEmailAddress()            -> String
    func getEmailSubject()            -> String
    func getTestSubscreens()          -> [(button :String, output :String)]
}
