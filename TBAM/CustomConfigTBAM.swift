//
//  CustomConfigTBAM.swift
//  TBAM
//
//  Created by Phill Zarfos on 5/28/16.
//  Copyright © 2016 Blue Heron Labs LLC. All rights reserved.
//

import UIKit

//
// TBAM links
// http://asoft4124.accrisoft.com/betham/index.php?src=gendocs&ref=AboutUs__App
// [DONE] http://asoft4124.accrisoft.com/betham/index.php?src=gendocs&ref=ContactUs_App
// [DONE] http://asoft4124.accrisoft.com/betham/index.php?src=gendocs&ref=Memberhood_App
// [DONE] http://asoft4124.accrisoft.com/betham/index.php?src=gendocs&ref=TorahStudyBroadcast_App
// [DONE] http://asoft4124.accrisoft.com/betham/index.php?src=gendocs&ref=WeeklyMeditations_App
//
// [DONE] http://www.tbam.org/index.php?src=events&srctype=events_lister_app
// [DONE] http://www.tbam.org/index.php?src=events&srctype=events_lister_app&category=Shabbat+and+Services
// [DONE] http://www.tbam.org/index.php?src=forms&ref=Do_a_Mitzvah
// [DONE] http://www.tbam.org/index.php?src=gendocs&ref=prayer
//        --> http://www.tbam.org/index.php?src=gendocs&ref=kiddush_wine_blessing_MP3_page
// [DONE] http://www.tbam.org/index.php?src=gendocs&ref=school_landing_page
// [DONE] http://www.tbam.org/index.php?src=membership&srctype=membership_lister_app
//
// [DONE] https://asoft4124.accrisoft.com/betham/index.php?src=forms&ref=Online_Donation_From_App
//
// [DONE] http://www.sundaystreams.com/ios/live/?id=571&token=57772827
//
// https://www.buzztouch.com/api/app/?command=getAppData&appGuid=JAE2556C93CCDF6FC07A86473&apiKey=4AAADCB2775068174B779C3&apiSecret=FE80E08DFF9F5ED544104BF
// https://www.buzztouch.com/applications063014/JAE2556C93CCDF6FC07A86473/documents/customHTML_BCA7948DA4C99914CE2ECBC.html
// http://www.buzztouch.com/applications063014/JAE2556C93CCDF6FC07A86473/documents/customHTML_7F872FC1EFE858ED52C1971.html
// http://www.google.com
//

class CustomConfigTBAM : CustomConfigProtocol
{
    func getBackgroundColor() -> UIColor
    {
        return UIColor(red:0.02, green:0.18, blue:0.31, alpha:1)  // dark blue #042F4E
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
        return "home_banner_tbam"
    }
    
    func getHomeImageAspect() -> UIViewContentMode
    {
        return .ScaleAspectFill
    }
    
    func getTextFont() -> UIFont
    {
        return UIFont.systemFontOfSize(17)
    }
    
    func getTextColor() -> UIColor
    {
        return UIColor.whiteColor()
    }
    
    func getWebAppURL() -> String
    {
        return ""
    }
    
    func getAlertURL() -> String
    {
        return "http://www.tbam.org/index.php?src=directory&view=appWidget&srctype=lister&direct=y"
    }
    
    func getHomeMenuNumRows() -> Int
    {
        return 3
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
        
        // site http://www.tbam.org/
        // ssl  https://asoft4124.accrisoft.com/betham/
        
        let URL = "http://www.tbam.org/"
        
        menu.append(HomeMenuItem(title: "Calendar",     icon: "mainmenu_calendar400x400c",    url: URL + "?src=events&srctype=events_lister_app"))
        menu.append(HomeMenuItem(title: "Contact",      icon: "mainmenu_contact400x400c",     url: "submenu://contact"))
        menu.append(HomeMenuItem(title: "Directory",    icon: "mainmenu_directory400x400c",   url: URL + "?src=membership&srctype=membership_lister_app"))
        menu.append(HomeMenuItem(title: "Live Stream",  icon: "mainmenu_livestream400x400c",  url: "http://www.sundaystreams.com/ios/live/?id=571&token=57772827"))
        
        menu.append(HomeMenuItem(title: "Prayer",       icon: "mainmenu_prayer400x400c",      url: URL + "?src=gendocs&ref=prayer"))
        menu.append(HomeMenuItem(title: "Torah Study",  icon: "mainmenu_torahstudy400x400c",  url: URL + "?src=gendocs&ref=TorahStudyBroadcast_App"))
        menu.append(HomeMenuItem(title: "Divrei Torah", icon: "mainmenu_divreitorah400x400c", url: URL + "?src=gendocs&ref=WeeklyMeditations_App"))
        menu.append(HomeMenuItem(title: "Services",     icon: "mainmenu_services400x400c",    url: URL + "?src=events&srctype=events_lister_app&category=Shabbat+and+Services"))
        
        menu.append(HomeMenuItem(title: "Schools",      icon: "mainmenu_schools400x400c",     url: URL + "?src=gendocs&ref=school_landing_page"))
        menu.append(HomeMenuItem(title: "Do a Mitzvah", icon: "mainmenu_doamitzvah400x400c",  url: URL + "?src=forms&ref=Do_a_Mitzvah"))
        menu.append(HomeMenuItem(title: "Donate",       icon: "mainmenu_donate400x400c",      url: "https://asoft4124.accrisoft.com/betham/?src=forms&ref=Online_Donation_From_App"))
        menu.append(HomeMenuItem(title: "Memberhood",   icon: "mainmenu_memberhood400x400c",  url: URL + "?src=gendocs&ref=Memberhood_App"))
        
        return menu
    }
    
    func getSubmenu(name :String) -> [HomeMenuItem]
    {
        var menu :[HomeMenuItem] = []
        menu.reserveCapacity(4)
        
        menu.append(HomeMenuItem(title: "Call Temple Beth Am",  subtext: "Tap to call our Main Office",   url: "phone://"))
        menu.append(HomeMenuItem(title: "Email Temple Beth Am", subtext: "Send an email to our office",   url: "email://"))
        menu.append(HomeMenuItem(title: "Staff Directory",      subtext: "View our full staff directory", url: "http://www.tbam.org/?src=gendocs&ref=ContactUs_App"))
        menu.append(HomeMenuItem(title: "Directions",           subtext: "",                              url: "map://"))
        
        return menu
    }
    
    func getInternalDomains() -> [String]
    {
        return [ "www.tbam.org", "tbam.org", "asoft4124.accrisoft.com" ]
    }
    
    func getExternalLinks() -> [String]
    {
        return [ "https://asoft4124.accrisoft.com/betham/?src=forms&ref=Online_Donation_From_App" ]
    }
    
    func getTitle() -> String
    {
        return "Temple Beth Am"
    }
    
    func getPhysicalAddress() -> String
    {
        return "5950 N. Kendall Drive, Pinecrest, FL 33156"
    }
    
    func getLocationLatitude() -> Double
    {
        return 25.689085
    }
    
    func getLocationLongitude() -> Double
    {
        return -80.2899098
    }
    
    func getPhoneNumber() -> String
    {
        return "3056676667"
    }
    
    func getEmailAddress() -> String
    {
        return "info@tbam.org"
    }
    
    func getEmailSubject() -> String
    {
        return "Temple Beth Am app feedback"
    }
    
    func getTestSubscreens() -> [(button :String, output :String)]
    {
        let menu = self.getHomeMenu()
        return [
            (button: menu[0].icon,  output: "02_Calendar"),
            (button: menu[11].icon, output: "03_Memberhood"),
        ]
    }
}
