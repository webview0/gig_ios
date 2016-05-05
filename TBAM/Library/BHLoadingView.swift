//
//  BHLoadingView.swift
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

// code based on LoadingOverlay view from Xamarin
// http://developer.xamarin.com/recipes/ios/standard_controls/popovers/display_a_loading_message/

public class BHLoadingView : UIView
{
    public var activitySpinner :UIActivityIndicatorView? = nil
    public var loadingLabel    :UILabel? = nil
    
    // MARK: - Sizes
    
    private func getSpinnerRect() -> CGRect
    {
        guard let spinner = self.activitySpinner else { return CGRectZero }
        
        let w = CGRectGetWidth(self.frame)
        let h = CGRectGetHeight(self.frame)

        let centerX = w / 2.0
        let centerY = h / 2.0

        let spinnerWidth  = CGRectGetWidth(spinner.frame)
        let spinnerHeight = CGRectGetHeight(spinner.frame)
        return CGRectMake(centerX - (spinnerWidth / 2.0), centerY - spinnerHeight - 20.0, spinnerWidth, spinnerHeight)
    }
    
    private func getLabelRect() -> CGRect
    {
        let w = CGRectGetWidth(self.frame)
        let h = CGRectGetHeight(self.frame)
        
        let centerX = w / 2.0
        let centerY = h / 2.0

        let labelWidth  :CGFloat = w - 20
        let labelHeight :CGFloat = 22
        
        return CGRectMake(centerX - (labelWidth / 2), centerY + 20, labelWidth, labelHeight)
    }
    
    // MARK: - View
    
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.createInitialViews()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        self.createInitialViews()
    }

    private func createInitialViews()
    {
        let alpha :CGFloat = 0.75
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        
        // create the activity spinner, center it horizontal and put it 5 points above center x
        self.activitySpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        self.activitySpinner!.frame = self.getSpinnerRect()
        self.activitySpinner!.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        self.addSubview(self.activitySpinner!)
        
        // create and configure the "Loading Data" label
        self.loadingLabel = UILabel(frame: self.getLabelRect())
        self.loadingLabel!.backgroundColor = UIColor.clearColor()
        self.loadingLabel!.textColor = UIColor.whiteColor()
        self.loadingLabel!.text = "Updating..."
        self.loadingLabel!.textAlignment = .Center
        self.loadingLabel!.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        self.addSubview(self.loadingLabel!)
    }
    
    public func adjustLayouts()
    {
        self.activitySpinner?.frame = self.getSpinnerRect()
        self.loadingLabel?.frame = self.getLabelRect()
    }
    
    public func updateRect(rect :CGRect)
    {
        self.frame = rect
        self.adjustLayouts()
        self.setNeedsDisplay()
    }
    
    public func setText(text :String)
    {
        self.loadingLabel?.text = text
    }
    
    public func startSpinner()
    {
        self.activitySpinner?.startAnimating()
        self.hidden = false
    }
    
    public func stopSpinner()
    {
        self.hidden = true
        self.activitySpinner?.stopAnimating()
    }
    
//    // Fades out the control and then removes it from the super view
//    public func hide()
//    {
//        UIView.Animate (
//        0.5, // duration
//        () => { Alpha = 0 },
//        () => { RemoveFromSuperview() }
//        )
//    }
}