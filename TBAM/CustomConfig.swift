//
//  CustomConfig.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

class CustomConfig
{
    #if CHARLOTTECHAMBER_DEBUG || CHARLOTTECHAMBER_RELEASE
    static let handle = CustomConfigCharlotteChamber()
    #elseif DALLASJCC_DEBUG || DALLASJCC_RELEASE
    static let handle = CustomConfigDallasJCC()
    #elseif FTLAUDERDALECHAMBER_DEBUG || FTLAUDERDALECHAMBER_RELEASE
    static let handle = CustomConfigFtLauderdale()
    #elseif MOBILEACCRISOFT_DEBUG || MOBILEACCRISOFT_RELEASE
    static let handle = CustomConfigMobileAccrisoft()
    #elseif SKUNKGURU_DEBUG || SKUNKGURU_RELEASE
    static let handle = CustomConfigSkunkGuru()
    #elseif TBAM_DEBUG || TBAM_RELEASE
    static let handle = CustomConfigTBAM()
    #elseif UPTOWN_DEBUG || UPTOWN_RELEASE
    static let handle = CustomConfigUptown()
    #else
//    assert(false)
    #endif
    
    fileprivate init() { }  //This prevents others from using the default '()' initializer for this class.
}

extension CustomConfig
{
    class func isFullWebApp() -> Bool
    {
        return ("" != CustomConfig.handle.getWebAppURL())
    }
}
