//
//  CustomConfig.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

class CustomConfig
{
    //#if DALLASJCC_DEBUG || DALLASJCC_RELEASE
    //static let handle = CustomConfigDallasJCC()
    //#else
    static let handle = CustomConfigDevel()
    //static let handle = CustomConfigTBAM()
    //#endif
    
    private init() { }  //This prevents others from using the default '()' initializer for this class.
}
