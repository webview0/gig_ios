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

open class BHLoadingView : UIView
{
    open var activitySpinner :UIActivityIndicatorView? = nil
    open var loadingLabel    :UILabel? = nil
    
    // MARK: - Sizes
    
    fileprivate func getSpinnerRect() -> CGRect
    {
        guard let spinner = self.activitySpinner else { return CGRect.zero }
        
        let w = self.frame.width
        let h = self.frame.height

        let centerX = w / 2.0
        let centerY = h / 2.0

        let spinnerWidth  = spinner.frame.width
        let spinnerHeight = spinner.frame.height
        return CGRect(x: centerX - (spinnerWidth / 2.0), y: centerY - spinnerHeight - 20.0, width: spinnerWidth, height: spinnerHeight)
    }
    
    fileprivate func getLabelRect() -> CGRect
    {
        let w = self.frame.width
        let h = self.frame.height
        
        let centerX = w / 2.0
        let centerY = h / 2.0

        let labelWidth  :CGFloat = w - 20
        let labelHeight :CGFloat = 22
        
        return CGRect(x: centerX - (labelWidth / 2), y: centerY + 20, width: labelWidth, height: labelHeight)
    }
    
    // MARK: - View
    
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.createInitialViews()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.createInitialViews()
    }

    fileprivate func createInitialViews()
    {
        let alpha :CGFloat = 0.75
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        
        // create the activity spinner, center it horizontal and put it 5 points above center x
        self.activitySpinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.activitySpinner!.frame = self.getSpinnerRect()
        self.activitySpinner!.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.addSubview(self.activitySpinner!)
        
        // create and configure the "Loading Data" label
        self.loadingLabel = UILabel(frame: self.getLabelRect())
        self.loadingLabel!.backgroundColor = UIColor.clear
        self.loadingLabel!.textColor = UIColor.white
        self.loadingLabel!.text = "Updating..."
        self.loadingLabel!.textAlignment = .center
        self.loadingLabel!.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.addSubview(self.loadingLabel!)
    }
    
    open func adjustLayouts()
    {
        self.activitySpinner?.frame = self.getSpinnerRect()
        self.loadingLabel?.frame = self.getLabelRect()
    }
    
    open func updateRect(_ rect :CGRect)
    {
        self.frame = rect
        self.adjustLayouts()
        self.setNeedsDisplay()
    }
    
    open func setText(_ text :String)
    {
        self.loadingLabel?.text = text
    }
    
    open func startSpinner()
    {
        self.activitySpinner?.startAnimating()
        self.isHidden = false
    }
    
    open func stopSpinner()
    {
        self.isHidden = true
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
