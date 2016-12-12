//
//  AddAddressViewController.swift
//  PartyApp
//
//  Created by XYZ on 2016/12/12.
//  Copyright © 2016年 CSCI-6907-Minghao Pu. All rights reserved.
//


import UIKit
import MapKit


class AddAddressViewController: UIViewController,UISearchBarDelegate,MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    var mapItem = [MKMapItem]()
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        self.mainMapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView()
        annotationView.canShowCallout = true
        annotationView.animatesDrop = true
        annotationView.pinTintColor = UIColor(red:0.046, green:0.741, blue:1, alpha:1)
        annotationView.leftCalloutAccessoryView = UIButton(type: UIButtonType.infoDark)
        annotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.infoLight)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        switch control {
        case view.leftCalloutAccessoryView!:
            MKMapItem.openMaps(with: mapItem, launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
        default:
            print("right callout")
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        let search = MKLocalSearch(request: localSearchRequest)
        search.start { response, error in
            if response == nil {
                let alert = UIAlertController(title: "Search Failed", message: "No results found. Try another search.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                let items = response!.mapItems
                for item in items {
                    let annotation = MapAnnotations(coordinate: item.placemark.coordinate, title:  item.placemark.name, subtitle: item.phoneNumber)
                    
                    let initialLocation = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                    
                    self.centerMapOnLocation(initialLocation)
                    self.mapItem.append(item)
                    self.mainMapView.addAnnotation(annotation)
                    self.mainMapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBarOutlet.showsCancelButton = false
        } else{
            searchBarOutlet.showsCancelButton = true
        }
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.searchBarOutlet.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAddress(_ sender: AnyObject) {
        
    }
    
}



