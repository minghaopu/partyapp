//
//  AddAddressViewController.swift
//  PartyApp
//
//  Created by roneil on 12/5/16.
//  Copyright © 2016 CSCI-6907-Minghao Pu. All rights reserved.
//


import UIKit
import MapKit


class AddAddressViewController: UIViewController,UISearchBarDelegate,MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var saveBtn: UIButton!
    
    weak var addViewController: AddViewController?
    weak var editViewController: EditViewController?
    
    var currentLocationInfo:MapAnnotations?
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
                self.currentLocationInfo = nil;
                self.saveBtn.setTitle("Close", for: UIControlState.normal)
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
                if items.count > 0 {
                    self.currentLocationInfo = MapAnnotations(coordinate: items[0].placemark.coordinate, title:  items[0].placemark.name, subtitle: items[0].phoneNumber)
                    self.saveBtn.setTitle("Save", for: UIControlState.normal)
                }else{
                    self.currentLocationInfo = nil
                    self.saveBtn.setTitle("Close", for: UIControlState.normal)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBarOutlet.showsCancelButton = false
            self.saveBtn.setTitle("Close", for: UIControlState.normal)
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
        if(currentLocationInfo != nil){
            if self.addViewController != nil{
                self.addViewController?.longitude = (currentLocationInfo?.coordinate)!.longitude
                self.addViewController?.latitude = (currentLocationInfo?.coordinate)!.latitude
                self.addViewController?.addressInput.text = (currentLocationInfo?.title)!
            }else if self.editViewController != nil{
                self.editViewController?.longitude = (currentLocationInfo?.coordinate)!.longitude
                self.editViewController?.latitude = (currentLocationInfo?.coordinate)!.latitude
                self.editViewController?.addressInput.text = (currentLocationInfo?.title)!
            }
        }
        if self.addViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else if self.editViewController != nil{
            self.navigationController?.popViewController(animated: true)
        }
    }
}



