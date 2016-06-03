//
//  CustomConfigDevel.swift
//  TBAM
//
//  Created by Phill Zarfos on 5/28/16.
//  Copyright © 2016 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class CustomConfigDevel : CustomConfigProtocol
{
    func getBackgroundColor() -> UIColor
    {
        return UIColor.blackColor()
    }
    
    func getStatusBarStyle() -> UIStatusBarStyle
    {
        return .LightContent
    }
    
    func getNavigationBarStyle() -> UIBarStyle
    {
        return .Black
    }
    
    func getHomeImageName() -> String
    {
        return "home_banner_demo"
    }
    
    func getHomeImageAspect() -> UIViewContentMode
    {
        return .ScaleAspectFill
    }
    
    func getTextFont() -> UIFont
    {
        return UIFont.boldSystemFontOfSize(20)
    }
    
    func getTextColor() -> UIColor
    {
        return UIColor.whiteColor()
        //return UIColor(red:0.98, green:0.33, blue:0.31, alpha:1.00)  // red-orange
    }
    
    func getAlertURL() -> String
    {
        return "http://rigel7.local/~phillz/freedom1/index.php?src=directory&view=alert&srctype=detail&refno=1"
    }
    
    func getHomeMenuNumRows() -> Int
    {
        return 2
    }
    
    func getHomeMenuNumColumns() -> Int
    {
        return 4
    }
    
    func getHomeMenu() -> [HomeMenuItem]
    {
        var menu :[HomeMenuItem] = []
        let num = self.getHomeMenuNumRows() * self.getHomeMenuNumColumns()
        menu.reserveCapacity(num)
        
        // site http://rigel7.local/~phillz/freedom1/
        // ssl  https://asoft10307.accrisoft.com/jccdallas/
        
        let URL = "http://rigel7.local/~phillz/freedom1/"
        menu.append(HomeMenuItem(title: "About",   icon: "menu_about",   url: URL + "?src=gendocs&ref=about"))
        menu.append(HomeMenuItem(title: "Hours",   icon: "menu_hours",   url: URL + "?src=gendocs&ref=hours"))
        menu.append(HomeMenuItem(title: "Events",  icon: "menu_events",  url: URL + "?src=gendocs&ref=events"))
        menu.append(HomeMenuItem(title: "News",    icon: "menu_news",    url: URL + "?displaytype=appDisplayType&src=news&srctype=lister"))
        menu.append(HomeMenuItem(title: "Camps",   icon: "menu_camps",   url: URL + "?displaytype=appDisplayType&src=gendocs&ref=Camps_app&category=Main"))
        menu.append(HomeMenuItem(title: "Fitness", icon: "menu_fitness", url: URL + "?displaytype=appDisplayType&src=gendocs&ref=Fitnessapp&category=Main"))
        menu.append(HomeMenuItem(title: "Blog",    icon: "menu_blog",    url: "https://asoft4124.accrisoft.com/betham/?src=membership&srctype=membership_lister_app"))
        menu.append(HomeMenuItem(title: "Photos",  icon: "menu_photos",  url: "https://asoft4124.accrisoft.com/betham/?src=forms&ref=Online_Donation_From_App"))
        
        return menu
    }
    
    func getSubmenu(name :String) -> [HomeMenuItem]
    {
        return []
    }
    
    func getInternalDomains() -> [String]
    {
        return [ "rigel7.local", "asoft4124.accrisoft.com/betham" ]
    }
    
    func getExternalLinks() -> [String]
    {
        return [ "https://asoft4124.accrisoft.com/betham/?src=forms&ref=Online_Donation_From_App" ]
    }
    
    func getTitle() -> String
    {
        return "My Demo Site"
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
        return "9415551212"
    }
    
    func getEmailAddress() -> String
    {
        return "devnull@example.com"
    }
    
    func getEmailSubject() -> String
    {
        return "Green Demo app feedback"
    }
    
    func getTestSubscreens() -> [(button :String, output :String)]
    {
        let menu = self.getHomeMenu()
        return [
            (button: menu[0].icon, output: "02_About"),
            //(button: menu[1].icon, output: "03_Hours"),
        ]
    }
}
