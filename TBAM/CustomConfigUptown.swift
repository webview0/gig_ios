//
//  CustomConfigUptown.swift
//  TBAM
//
//  Created by Phill Zarfos on 5/28/16.
//  Copyright © 2016 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

class CustomConfigUptown : CustomConfigProtocol
{
	func getBackgroundColor() -> UIColor
	{
        //return UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
	}
	
	func getStatusBarStyle() -> UIStatusBarStyle
	{
		return .default
	}
	
	func getNavigationBarStyle() -> UIBarStyle
	{
		return .default
	}
	
	func getHomeImageName() -> String
	{
		return "home_banner_uptown"
	}
	
	func getHomeImageAspect() -> UIViewContentMode
	{
		return .scaleAspectFit
	}
	
	func getTextFont() -> UIFont
	{
		return UIFont.systemFont(ofSize: 17)
	}
	
	func getTextColor() -> UIColor
	{
		return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
	}
	
    func getWebAppURL() -> String
    {
        return "http://asoft11139.accrisoft.com/predefined/index.php?src=directory&view=appHome&srctype=appHome_lister"
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
		return 4
	}
	
	func getHomeMenu() -> [HomeMenuItem]
	{
		var menu :[HomeMenuItem] = []
		menu.reserveCapacity(4)
		menu.append(HomeMenuItem(title: "Join",               icon: "uptown_join",               url:"http://asoft20128.accrisoft.com/demo26/index.php?submenu=_joinnow&src=forms&ref=Join+the+Chamber&id=Join+the+Chamber"))
		menu.append(HomeMenuItem(title: "Business Directory", icon: "uptown_business_directory", url:"http://asoft20128.accrisoft.com/demo26/index.php?submenu=_bizdir&src=membership"))
		menu.append(HomeMenuItem(title: "Events",             icon: "uptown_events",             url:"http://asoft20128.accrisoft.com/demo26/index.php?src=events&srctype=glance"))
		menu.append(HomeMenuItem(title: "Login",              icon: "uptown_login",              url:"http://asoft20128.accrisoft.com/demo26/index.php?src=membership&srctype=myaccount"))
		return menu

	}
	
	func getSubmenu(_ name :String) -> [HomeMenuItem]
	{
		// fall thru
		return []
	}
	
	func getInternalDomains() -> [String]
	{
        return [ "asoft11139.accrisoft.com/predefined",
                 "www.asoft11139.accrisoft.com/predefined" ]
	}
	
	func getExternalLinks() -> [String]
	{
		return []
	}
	
	func getTitle() -> String
	{
		return ""
	}
	
	func getPhysicalAddress() -> String
	{
		return ""
	}
	
	func getLocationLatitude() -> Double
	{
		return 0
	}
	
	func getLocationLongitude() -> Double
	{
		return 0
	}
	
	func getPhoneNumber() -> String
	{
		return ""
	}
	
	func getEmailAddress() -> String
	{
		return ""
	}
	
	func getEmailSubject() -> String
	{
		return ""
	}
	
	func getTestSubscreens() -> [(button :String, output :String)]
	{
		//let menu = self.getHomeMenu()
		return [
		]
	}
}
