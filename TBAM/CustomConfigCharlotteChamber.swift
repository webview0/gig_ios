//
//  CustomConfig
//
//  THIS FILE IS AUTO-GENERATED
//

import UIKit

class CustomConfigCharlotteChamber : CustomConfigProtocol
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
		return "home_banner_tbam"
	}

	func getHomeImageAspect() -> UIViewContentMode
	{
		return .scaleAspectFill
	}

	func getTextFont() -> UIFont
	{
		return UIFont.systemFont(ofSize: 17)
	}

	func getTextColor() -> UIColor
	{
		return UIColor.red
	}

	func getWebAppURL() -> String
	{
		return "https://charlottechamber.com/app/"
	}

	func getAlertURL() -> String
	{
		return ""
	}

	func getHomeMenuNumRows() -> Int
	{
		return 0
	}

	func getHomeMenuNumColumns() -> Int
	{
		return 0
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
		return [ "charlottechamber.com", "www.charlottechamber.com" ]
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
