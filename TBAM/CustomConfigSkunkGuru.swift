//
//  CustomConfig 
//
//  THIS FILE IS AUTO-GENERATED
//

import UIKit

class CustomConfigSkunkGuru : CustomConfigProtocol
{
	func getBackgroundColor() -> UIColor
	{
		return UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1)
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
		return "home_banner_skunkguru"
	}
	
	func getHomeImageAspect() -> UIViewContentMode
	{
		return .ScaleAspectFit
	}
	
	func getTextFont() -> UIFont
	{
		return UIFont.systemFontOfSize(17)
	}
	
	func getTextColor() -> UIColor
	{
		return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
	}
	
	func getAlertURL() -> String
	{
		return "http://skunk.guru/index.php?src=directory&view=AppAlerts"
	}
	
	func getHomeMenuNumRows() -> Int
	{
		return 3
	}
	
	func getHomeMenuNumColumns() -> Int
	{
		return 3
	}
	
	func getHomeMenu() -> [HomeMenuItem]
	{
		var menu :[HomeMenuItem] = []
		menu.reserveCapacity(9)
		menu.append(HomeMenuItem(title: "Calorie Calculator", icon: "menu_skunk_calorie",  url:"http://skunk.guru/index.php?src=gendocs&ref=Calorie%20Calculator&category=Mobile"))
		menu.append(HomeMenuItem(title: "Weight Tracker",     icon: "menu_skunk_weight",   url:"http://skunk.guru/index.php?src=gendocs&ref=Weight%20Monitor&category=Mobile"))
		menu.append(HomeMenuItem(title: "Diet",               icon: "menu_skunk_diet",     url:"http://skunk.guru/index.php?src=gendocs&ref=Suggested%20Foods&category=Mobile"))
		menu.append(HomeMenuItem(title: "Blog",               icon: "menu_skunk_blog",     url:"https://skunk.guru/index.php?src=blog&srctype=blog_lister_mobile"))
		menu.append(HomeMenuItem(title: "Events",             icon: "menu_skunk_events",   url:"https://skunk.guru/index.php?src=events&srctype=events_lister_mobile"))
		menu.append(HomeMenuItem(title: "Legal States",       icon: "menu_skunk_states",   url:"https://skunk.guru/index.php?src=directory&view=area_map&srctype=area_map_mobile"))
		menu.append(HomeMenuItem(title: "Find A Vet",         icon: "menu_skunk_findvet",  url:"http://skunk.guru/index.php?src=directory&view=Vet_List&srctype=Vet_List_App"))
		menu.append(HomeMenuItem(title: "Submit a Vet",       icon: "menu_skunk_submit",   url:"https://skunk.guru/index.php?src=forms&ref=Submit%20a%20Vet&mobileKey=0404477012"))
		menu.append(HomeMenuItem(title: "Settings",           icon: "menu_skunk_settings", url:"http://skunk.guru/index.php?src=gendocs&ref=Settings&category=Mobile"))
		return menu

	}
	
	func getSubmenu(name :String) -> [HomeMenuItem]
	{
		
		// fall thru
		return []
	}
	
	func getInternalDomains() -> [String]
	{
		return [ "skunk.guru",
			"www.skunk.guru" ]
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
		let menu = self.getHomeMenu()
		return [
			
		]
	}
}
