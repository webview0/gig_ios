//
//  TBAMUITests.swift
//  TBAMUITests
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import XCTest

class TBAMUITests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    func testTakeScreenshots()
    {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        
        // grab home screen
        snapshot("01_Home")
        
        // grab screenshots for the subscreens
        let back = "Back"
        let subscreens = CustomConfig.handle.getTestSubscreens()
        for item in subscreens {
            collectionViewsQuery.images[item.button].tap()
            snapshot(item.output)
            app.navigationBars.elementBoundByIndex(0).staticTexts[back].tap()
        }
    }
    
    func testTBAMSubmenu()
    {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews

        collectionViewsQuery.images["mainmenu_contact400x400c"].tap()
        snapshot("Test_Contacts")
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testExample()
    {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
