//
//  MapViewController.swift
//  PartyApp
//
//  Created by roneil on 12/11/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mainMapView: MKMapView!
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var location: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create mkmapview
        self.mainMapView = MKMapView(frame:self.view.frame)
        self.view.addSubview(self.mainMapView)
        
        //set the map to standard
        self.mainMapView.mapType = MKMapType.standard
        
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        

        let center:CLLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                                  span: currentLocationSpan)
        
        self.mainMapView.setRegion(currentRegion, animated: true)
        
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = CLLocation(latitude: self.latitude,
                                                 longitude: self.longitude).coordinate
        objectAnnotation.title = self.location
        self.mainMapView.addAnnotation(objectAnnotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
