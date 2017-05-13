//
//  CustomConfigTest.swift
//  TBAM
//
//  Created by Phill Zarfos on 5/28/16.
//  Copyright © 2016 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class CustomConfigTest : CustomConfigProtocol
{
    func getBackgroundColor() -> UIColor
    {
        return UIColor.black
    }
    
    func getStatusBarStyle() -> UIStatusBarStyle
    {
        return .lightContent
    }
    
    func getNavigationBarStyle() -> UIBarStyle
    {
        return .black
    }
    
    func getHomeImageName() -> String
    {
        return "home_banner_test"
    }
    
    func getHomeImageAspect() -> UIViewContentMode
    {
        return .scaleAspectFill
    }
    
    func getTextFont() -> UIFont
    {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    func getTextColor() -> UIColor
    {
        return UIColor.white
    }
    
    func getWebAppURL() -> String
    {
        return ""
    }
    
    func getAlertURL() -> String
    {
        return ""
    }
    
    func getHomeMenuNumRows() -> Int
    {
        return 1
    }
    
    func getHomeMenuNumColumns() -> Int
    {
        return 1
    }
    
    func getHomeMenu() -> [HomeMenuItem]
    {
        var menu :[HomeMenuItem] = []
        let num = self.getHomeMenuNumRows() * self.getHomeMenuNumColumns()
        menu.reserveCapacity(num)
        
        let URL = "http://rigel7.local/~phillz/unittest/"
        menu.append(HomeMenuItem(title: "About", icon: "menu_about", url: URL + "?src=gendocs&ref=about"))
        
        return menu
    }
    
    func getSubmenu(_ name :String) -> [HomeMenuItem]
    {
        return []
    }
    
    func getInternalDomains() -> [String]
    {
        return [ "rigel7.local" ]
    }
    
    func getExternalLinks() -> [String]
    {
        return [ "https://unittest.accrisoft.com/?src=forms&ref=Online_Donation_From_App" ]
    }
    
    func getTitle() -> String
    {
        return "Unit Test Site"
    }
    
    func getPhysicalAddress() -> String
    {
        return "60655 US-60, Hope, AZ 85348"
    }
    
    func getLocationLatitude() -> Double
    {
        return 33.7211
    }
    
    func getLocationLongitude() -> Double
    {
        return -113.6944
    }
    
    func getPhoneNumber() -> String
    {
        return "9415554444"
    }
    
    func getEmailAddress() -> String
    {
        return "devnull@example.com"
    }
    
    func getEmailSubject() -> String
    {
        return "Green Test Run"
    }
    
    func getTestSubscreens() -> [(button :String, output :String)]
    {
        let menu = self.getHomeMenu()
        return [
            (button: menu[0].icon, output: "02_TestOutput"),
        ]
    }
}
