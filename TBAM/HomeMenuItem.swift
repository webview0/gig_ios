//
//  HomeMenuItem.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import Foundation

class HomeMenuItem
{
    var title    = ""
    var subtext  = ""
    var icon     = ""
    var url      = ""
    var external = false
    
    init()
    {
        self.title    = ""
        self.subtext  = ""
        self.icon     = ""
        self.url      = ""
        self.external = false
    }
    
    init(title :String, icon :String, url :String)
    {
        self.title    = title
        self.subtext  = ""
        self.icon     = icon
        self.url      = url
        self.external = false
    }
    
    init(title :String, icon :String, url :String, external :Bool)
    {
        self.title    = title
        self.subtext  = ""
        self.icon     = icon
        self.url      = url
        self.external = external
    }
    
    init(title :String, subtext :String, url :String)
    {
        self.title    = title
        self.subtext  = subtext
        self.icon     = ""
        self.url      = url
        self.external = false
    }
}