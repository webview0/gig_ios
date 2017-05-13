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
    internal let BUTTON_OPEN_MAPS = 1001
    
    @IBOutlet weak var mapView: MKMapView?
    
    // MARK: - View Controller
    
    class func loadFromStoryboard() -> MapViewController?
    {
        let STORYBOARD_ID = "Map"
        let vc = AppDelegate.storyboard().instantiateViewController(withIdentifier: STORYBOARD_ID) as? MapViewController
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = CustomConfig.handle.getBackgroundColor()
        
        self.mapView?.delegate = self
        
        self.loadLocation()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : CustomConfig.handle.getTextColor() ]
        self.navigationController?.navigationBar.barTintColor        = CustomConfig.handle.getBackgroundColor()
        self.navigationController?.navigationBar.tintColor           = CustomConfig.handle.getTextColor()
        self.navigationController?.navigationBar.isTranslucent         = false
        
        let title = self.navigationItem.backBarButtonItem?.title ?? "Back"
        let color = CustomConfig.handle.getTextColor()
        self.navigationItem.leftBarButtonItem = BHBarButtonBack.factory(title, tintColor: color, target: self, action: #selector(MapViewController.pressedBack))
        
        guard let mv = self.mapView else { return }
        
        for pin in mv.annotations {
            mv.selectAnnotation(pin, animated: true)
            break
        }
    }
    
    // MARK: - Helper Functions
    
    internal func loadLocation()
    {
        // use this function to convert the street address to lat-lon coordinates
        //self.lookupAddress(self.getConfig().getPhysicalAddress())
        
        let coordinate = CLLocationCoordinate2D(latitude: CustomConfig.handle.getLocationLatitude(), longitude: CustomConfig.handle.getLocationLongitude())
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = CustomConfig.handle.getTitle()
        annotation.subtitle = "Tap for Driving Directions"
        self.mapView?.addAnnotation(annotation)
        
        let meters :Double = 100000
        let region = MKCoordinateRegionMakeWithDistance(coordinate, meters, meters)
        self.mapView?.region = region
    }
    
    internal func lookupAddress(_ address :String)
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
    
    internal func openInMaps(_ coordinate :CLLocationCoordinate2D?)
    {
        guard let coordinate = coordinate else { return }
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let item = MKMapItem(placemark: placemark)
        item.name = CustomConfig.handle.getTitle()
        item.openInMaps(launchOptions: [ MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving ])
    }
    
    // MARK: - Actions
    
    func pressedBack()
    {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Map View Delegate

extension MapViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let PIN_IDENTIFIER = "MapPin"
        var view :MKPinAnnotationView
        if let dq = mapView.dequeueReusableAnnotationView(withIdentifier: PIN_IDENTIFIER) as? MKPinAnnotationView {
            view = dq
            view.annotation = annotation
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: PIN_IDENTIFIER)
        }
        //if #available(iOS 9.0, *) {
        //    view.pinTintColor = UIColor.blueColor()
        //}
        
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        view.rightCalloutAccessoryView!.tag = self.BUTTON_OPEN_MAPS
        view.canShowCallout = true
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if (self.BUTTON_OPEN_MAPS == control.tag) {
            self.openInMaps(view.annotation?.coordinate)
        }
    }
}
