//
//  CustomConfig
//
//  THIS FILE IS AUTO-GENERATED
//

import UIKit

class CustomConfigMobileAccrisoft : CustomConfigProtocol
{
	func getBackgroundColor() -> UIColor
	{
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
		return "home_banner_charlotte"
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
		return "https://mobile.accrisoft.com/"
	}

	func getAlertURL() -> String
	{
		return ""
	}

	func getHomeMenuNumRows() -> Int
	{
		return 2
	}

	func getHomeMenuNumColumns() -> Int
	{
		return 2
	}

	func getHomeMenu() -> [HomeMenuItem]
	{
		var menu :[HomeMenuItem] = []
		menu.reserveCapacity(0)
		return menu

	}

	func getSubmenu(_ name :String) -> [HomeMenuItem]
	{
		
		// fall thru
		return []
	}

	func getInternalDomains() -> [String]
	{
		return [
            "mobile.accrisoft.com",
			"www.mobile.accrisoft.com" ]
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
