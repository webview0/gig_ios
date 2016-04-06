//
//  MapViewController.swift
//  TBAM
//
//  Created by Phill Zarfos on 12/17/15.
//  Copyright © 2015 Blue Heron Labs LLC. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : CustomViewController
{
    @IBOutlet weak var mapView: MKMapView?
    
    // MARK: - View Controller
    
    class func loadFromStoryboard() -> MapViewController?
    {
        let STORYBOARD_ID = "Map"
        let vc = AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? MapViewController
        return vc
    }
    
    class func loadNavigationFromStoryboard() -> UINavigationController?
    {
        let STORYBOARD_ID = "MapNav"
        return AppDelegate.storyboard().instantiateViewControllerWithIdentifier(STORYBOARD_ID) as? UINavigationController
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem?.title = "Done"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.getConfig().getBackgroundColor()
        
        self.loadLocation()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        guard let mv = self.mapView else { return }
        
        for pin in mv.annotations {
            mv.selectAnnotation(pin, animated: true)
            break
        }
    }
    
    // MARK: - Map
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
//    {
//        let PIN_IDENTIFIER = "MapPin"
//        var view :MKPinAnnotationView
//        if let dq = mapView.dequeueReusableAnnotationViewWithIdentifier(PIN_IDENTIFIER) as? MKPinAnnotationView {
//            view = dq
//            view.annotation = annotation
//        } else {
//            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: PIN_IDENTIFIER)
//        }
//        if #available(iOS 9.0, *) {
//            view.pinTintColor = UIColor.blueColor()
//        }
////            view.leftCalloutAccessoryView  = self.makeLeftButton(annotation.getFavoriteID(), pinType: annotation.type)
////            view.rightCalloutAccessoryView = self.makeRightButton(annotation.getFavoriteID())
//        return view
//    }
    
    func loadLocation()
    {
        // use this function to convert the street address to lat-lon coordinates
        //self.lookupAddress(self.getConfig().getPhysicalAddress())
        
        let coordinate = CLLocationCoordinate2D(latitude: self.getConfig().getLocationLatitude(), longitude: self.getConfig().getLocationLongitude())
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = self.getConfig().getTitle()
        self.mapView?.addAnnotation(annotation)
        
        let meters :Double = 100000
        let region = MKCoordinateRegionMakeWithDistance(coordinate, meters, meters)
        self.mapView?.region = region
    }
    
    // MARK: - Helper Functions
    
    internal func lookupAddress(address :String)
    {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            [weak self]
            placemarks, error in
            if let _ = self, let arr = placemarks {
                if arr.count > 0 {
                    let placemark = arr[0]
                    if let loc = placemark.location {
                        let coordinate = loc.coordinate
                        print("CLLocationCoordinate2D(latitude: \(coordinate.latitude), longitude: \(coordinate.longitude))")
                    }
                }
            }
        }
    }
}