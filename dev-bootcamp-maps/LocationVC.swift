//
//  SecondViewController.swift
//  dev-bootcamp-maps
//
//  Created by Bartosz Odrzywołek on 15/05/16.
//  Copyright © 2016 Bartosz. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let regionRadius: CLLocationDistance = 100
    let locationManager = CLLocationManager()

    let addresses = [
    "The London Pavillion,1 Piccadilly Circus,London W1J 0DA,Wielka Brytania",
    "20 Sherwood St,London W1F 7ED,Wielka Brytania",
    "5 Air St,Piccadilly,London W1J 0AD,Wielka Brytania"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        for add in addresses {
            getPlacemarkFromAddress(add)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerUserLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(BootcampAnnotation) {
            let annoview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoview.pinTintColor = UIColor.blackColor()
            annoview.animatesDrop = true
            return annoview
            
        } else if annotation.isKindOfClass(MKUserLocation) {
            return nil
        } // the else if above is redundant. It's there just to remind how to check for user location
        
        return nil
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            centerUserLocation(loc)
        }
    }
    
    func createAnnotationFromLocation(location: CLLocation) {
        let bootcamp = BootcampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    //We have a valid location with coordinates
                    self.createAnnotationFromLocation(loc)
                }
            }
        }
    }
    
    
    
    
    
}

