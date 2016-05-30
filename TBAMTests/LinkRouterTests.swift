//
//  LinkRouterTests.swift
//  TBAM Tests
//
//  Created by Phill Zarfos on 12/11/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import XCTest

class LinkRouterTests : XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testExternalLinks()
    {
        var url = "http://rigel7.local"
        var actual = LinkRouter.isExternalLink(url)
        XCTAssertFalse(actual, "LinkRouter.isExternalLink(\(url)) - Expected false got \(actual)")

        url = "http://rigel7.local/~phillz/unittest/?src=gendocs&ref=about"
        actual = LinkRouter.isExternalLink(url)
        XCTAssertFalse(actual, "LinkRouter.isExternalLink(\(url)) - Expected false got \(actual)")
        
        url = "https://unittest.accrisoft.com/?src=forms&ref=Online_Donation_From_App"
        actual = LinkRouter.isExternalLink(url)
        XCTAssertTrue(actual, "LinkRouter.isExternalLink(\(url)) - Expected true got \(actual)")
        
        url = "http://www.google.com"
        actual = LinkRouter.isExternalLink(url)
        XCTAssertTrue(actual, "LinkRouter.isExternalLink(\(url)) - Expected true got \(actual)")
    }
    
    func testInternalMediaPlayer()
    {
        var url = "http://rigel7.local/~phillz/unittest/?src=gendocs&ref=about"
        var actual = LinkRouter.willUseInternalMediaPlayer(NSURLRequest(URL: NSURL(string: url)!))
        XCTAssertFalse(actual, "LinkRouter.willUseInternalMediaPlayer(\(url)) - Expected false got \(actual)")
        
        url = "http://rigel7.local/~phillz/unittest/jailbreak.mp3"
        actual = LinkRouter.willUseInternalMediaPlayer(NSURLRequest(URL: NSURL(string: url)!))
        XCTAssertTrue(actual, "LinkRouter.willUseInternalMediaPlayer(\(url)) - Expected false got \(actual)")
        
        url = "http://rigel7.local/~phillz/unittest/clientuploads/audio/jailbreak.mp3"
        actual = LinkRouter.willUseInternalMediaPlayer(NSURLRequest(URL: NSURL(string: url)!))
        XCTAssertTrue(actual, "LinkRouter.willUseInternalMediaPlayer(\(url)) - Expected false got \(actual)")
        
        url = "http://rigel7.local/~phillz/unittest/clientuploads/video/commercial.mp4"
        actual = LinkRouter.willUseInternalMediaPlayer(NSURLRequest(URL: NSURL(string: url)!))
        XCTAssertFalse(actual, "LinkRouter.willUseInternalMediaPlayer(\(url)) - Expected false got \(actual)")
        
        url = "http://rigel7.local/~phillz/unittest/clientuploads/docs/help.txt"
        actual = LinkRouter.willUseInternalMediaPlayer(NSURLRequest(URL: NSURL(string: url)!))
        XCTAssertFalse(actual, "LinkRouter.willUseInternalMediaPlayer(\(url)) - Expected false got \(actual)")
    }
}
