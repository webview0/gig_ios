//
//  CustomConfig.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

class CustomConfig
{
    #if DALLASJCC_DEBUG || DALLASJCC_RELEASE
    static let handle = CustomConfigDallasJCC()
    #elseif TBAM_DEBUG || TBAM_RELEASE
    static let handle = CustomConfigTBAM()
    #elseif UPTOWN_DEBUG || UPTOWN_RELEASE
    static let handle = CustomConfigUptown()
    #elseif SKUNKGURU_DEBUG || SKUNKGURU_RELEASE
    static let handle = CustomConfigSkunkGuru()
    #else
//    assert(false)
    #endif
    
    private init() { }  //This prevents others from using the default '()' initializer for this class.
}

extension CustomConfig
{
    class func isFullWebApp() -> Bool
    {
        return ("" != CustomConfig.handle.getWebAppURL())
    }
}
