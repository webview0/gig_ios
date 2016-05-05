//
//  BHBarButtonBack.swift
//  Blue Heron Labs UI Library for Swift
//
//  http://blueheronlabs.net/
//
//
//  The software in this Core library is licensed under the MIT License,
//  and was created by Blue Heron Labs LLC, except where otherwise noted.
//
//  Copyright (c) 2014 Blue Heron Labs LLC. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software library and documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

/**
 * A UIBarButtonItem for Back button with back arrow.
 * Use this class when you have to control when the user presses the Back button.
 *
 * Download the images here:
 * https://github.com/youknowone/UIKitResources
 *
 * Example Usage:
 *
 * override func viewWillAppear(animated: Bool)
 * {
 *     super.viewWillAppear(animated)
 *
 *     let title = self.navigationItem.backBarButtonItem?.title ?? "Back"
 *     let color = UIColor.greenColor()
 *     self.navigationItem.leftBarButtonItem = BHBarButtonBack.factory(title, tintColor: color, target: self, action: #selector(WebViewController.pressedBack))
 * }
 *
 * func pressedBack()
 * {
 *     self.navigationController?.popViewControllerAnimated(true)
 * }
 */
class BHBarButtonBack : UIBarButtonItem
{
    class func factory(title :String, tintColor :UIColor, target: AnyObject?, action: Selector) -> UIBarButtonItem
    {
        if let img = UIImage(named: "UINavigationBarBackIndicatorDefault")?.imageWithRenderingMode(.AlwaysTemplate) {
            let imageView = UIImageView(image: img)
            imageView.tintColor = tintColor
            
            let backLabel = UILabel()
            backLabel.text = title
            backLabel.textColor = tintColor
            backLabel.sizeToFit()
            
            let PADDING :CGFloat = 6
            let h = max(CGRectGetHeight(imageView.frame), CGRectGetHeight(backLabel.frame))
            
            backLabel.frame.origin.x = imageView.frame.origin.x + CGRectGetWidth(imageView.frame) + PADDING
            backLabel.frame.origin.y = (h - CGRectGetHeight(backLabel.frame)) / 2 + 1
            
            let vx = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(backLabel.frame) + CGRectGetWidth(imageView.frame) + PADDING, h))
            vx.addSubview(imageView)
            vx.addSubview(backLabel)
            
            let gesture = UITapGestureRecognizer(target: target, action: action)
            vx.addGestureRecognizer(gesture)
            vx.userInteractionEnabled = true
            
            return UIBarButtonItem(customView: vx)
        }
        
        // fallback to just show unicode arrow with text
        let unicodeArrow = "\u{25C1}"
        return UIBarButtonItem(title: "\(unicodeArrow) \(title)", style: .Plain, target: target, action: action)
    }
}