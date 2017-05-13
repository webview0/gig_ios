//
//  CustomConfigDallasJCC.swift
//  TBAM
//
//  Created by Phill Zarfos on 5/28/16.
//  Copyright © 2016 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class CustomConfigDallasJCC : CustomConfigProtocol
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
        //return "home_banner_demo"
        return "home_banner_dallasjcc"
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
        //return UIColor(red:0.98, green:0.33, blue:0.31, alpha:1.00)  // red-orange
    }
    
    func getWebAppURL() -> String
    {
        return "http://jccdallas.org/index.php?src=directory&view=appHome&srctype=appHome_lister"
    }
    
    func getAlertURL() -> String
    {
        return "http://www.jccdallas.org/index.php?src=directory&view=appWidget&srctype=lister&direct=y"
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
        
        // site http://www.jccdallas.org/
        // ssl  https://asoft10307.accrisoft.com/jccdallas/
        
        let URL = "http://www.jccdallas.org"
        menu.append(HomeMenuItem(title: "About",   icon: "menu_about",   url: URL + "?displaytype=appDisplayType&src=gendocs&ref=AboutApp&category=Main"))
        menu.append(HomeMenuItem(title: "Hours",   icon: "menu_hours",   url: URL + "?displaytype=appDisplayType&src=gendocs&ref=HoursApp&category=Main"))
        menu.append(HomeMenuItem(title: "Events",  icon: "menu_events",  url: URL + "?displaytype=appDisplayType&src=events"))
        menu.append(HomeMenuItem(title: "News",    icon: "menu_news",    url: URL + "?displaytype=appDisplayType&src=news&srctype=lister"))
        menu.append(HomeMenuItem(title: "Camps",   icon: "menu_camps",   url: URL + "?displaytype=appDisplayType&src=gendocs&ref=Camps_app&category=Main"))
        menu.append(HomeMenuItem(title: "Fitness", icon: "menu_fitness", url: URL + "?displaytype=appDisplayType&src=gendocs&ref=Fitnessapp&category=Main"))
        menu.append(HomeMenuItem(title: "Blog",    icon: "menu_blog",    url: URL + "?displaytype=appDisplayType&src=blog&srctype=blog_latest"))
        menu.append(HomeMenuItem(title: "Photos",  icon: "menu_photos",  url: URL + "?displaytype=appDisplayType&src=photo"))
        
        return menu
    }
    
    func getSubmenu(_ name :String) -> [HomeMenuItem]
    {
        return []
    }
    
    func getInternalDomains() -> [String]
    {
        return [ "www.jccdallas.org", "jccdallas.org", "asoft10307.accrisoft.com/jccdallas" ]
    }
    
    func getExternalLinks() -> [String]
    {
        return [ "" ]
    }
    
    func getTitle() -> String
    {
        return "My Dallas JCC"
    }
    
    func getPhysicalAddress() -> String
    {
        return "7900 Northaven Road, Dallas, TX 75230"
    }
    
    func getLocationLatitude() -> Double
    {
        return 32.899997
    }
    
    func getLocationLongitude() -> Double
    {
        return -96.773432
    }
    
    func getPhoneNumber() -> String
    {
        return "214­739­2737"
    }
    
    func getEmailAddress() -> String
    {
        return "Caring@jccdallas.org"
    }
    
    func getEmailSubject() -> String
    {
        return "Dallas JCC app feedback"
    }
    
    func getTestSubscreens() -> [(button :String, output :String)]
    {
        let menu = self.getHomeMenu()
        return [
            (button: menu[0].icon, output: "02_About"),
            (button: menu[1].icon, output: "03_Hours"),
        ]
    }
}
