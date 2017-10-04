//
//  CustomConfig
//
//  THIS FILE IS AUTO-GENERATED
//

import UIKit

class CustomConfigFtLauderdale : CustomConfigProtocol
{
	func getBackgroundColor() -> UIColor
	{
		return UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
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
		return ""
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
		return UIColor(red: 0.102, green: 0.153, blue: 0.196, alpha: 1)
	}

	func getWebAppURL() -> String
	{
		return "http://www.ftlchamber.com/app"
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
		return [ "www.ftlchamber.com",
			"ftlchamber.com",
			"asoft8235.accrisoft.com/ftlchamber" ]
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
