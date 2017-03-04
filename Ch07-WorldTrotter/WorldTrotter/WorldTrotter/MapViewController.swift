//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Erik Waterham on 2/28/17.
//  Copyright © 2017 Erik Waterham. All rights reserved.
//

//import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var trackingLocation = false

    // pin locations
    let pinCoordinateOne = CLLocationCoordinate2DMake(50.9129, 5.9764)
    let pinCoordinateTwo = CLLocationCoordinate2DMake(52.4946, 5.5028)
    let pinCoordinateThree = CLLocationCoordinate2DMake(52.3722, 4.9169)
    var visitingPin: Int = -1
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
//        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
//        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
        
        // location auth stuff
        locationManager.requestAlwaysAuthorization()    // ask for authorization from user
        locationManager.requestWhenInUseAuthorization() // for use in foreground
        
        // add a locate button
        let button = UIButton()
        button.frame = CGRect(x: UIScreen.main.bounds.width - 90, y: UIScreen.main.bounds.height - 100, width: 70, height: 30)
        button.setTitle("Locate", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(MapViewController.locationButtonWasPressed(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        // add a button for visiting pins
        let pinButton = UIButton()
        pinButton.frame = CGRect(x: UIScreen.main.bounds.width - 90, y: UIScreen.main.bounds.height - 150, width: 70, height: 30)
        pinButton.setTitle("Pins", for: .normal)
        pinButton.backgroundColor = UIColor.red
        pinButton.addTarget(self, action: #selector(MapViewController.pinButtonWasPressed(_:)), for: .touchUpInside)
        self.view.addSubview(pinButton)
        
        // drop 3 pins
        var pins = [MKPointAnnotation]()
        for _ in 0..<3 {
            pins.append(MKPointAnnotation())
        }
        pins[0].coordinate = self.pinCoordinateOne
        pins[0].title = "Birth"
        pins[1].coordinate = self.pinCoordinateTwo
        pins[1].title = "Home"
        pins[2].coordinate = self.pinCoordinateThree
        pins[2].title = "Study"
        for i in 0..<3 {
            mapView.addAnnotation(pins[i])
        }
       
    }
 
    func pinButtonWasPressed(_ sender: UIButton) {
        // stop tracking location if user wants to view pins
        if self.trackingLocation {
            self.locationManager.stopUpdatingLocation()
            self.trackingLocation = false
        }
        
        let regionOne = MKCoordinateRegion(center: self.pinCoordinateOne, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let regionTwo = MKCoordinateRegion(center: self.pinCoordinateTwo, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let regionThree = MKCoordinateRegion(center: self.pinCoordinateThree, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        switch self.visitingPin {
        case -1:
            mapView.setRegion(regionOne, animated: true)
            self.visitingPin = 0
        case 0:
            mapView.setRegion(regionTwo, animated: true)
            self.visitingPin = 1
        case 1:
            mapView.setRegion(regionThree, animated: true)
            self.visitingPin = 2
        case 2:
            mapView.setRegion(regionOne, animated: true)
            self.visitingPin = 0
        default:
            break
        }
    }
   
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    
    func locationButtonWasPressed(_ sender: UIButton) {
        if !self.trackingLocation {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
                mapView.showsUserLocation = true
                self.trackingLocation = true
            }
        }
        else {
            if CLLocationManager.locationServicesEnabled() {
                let region: MKCoordinateRegion = MKCoordinateRegionMake(mapView.centerCoordinate, MKCoordinateSpanMake(180, 360))
                mapView.setRegion(region, animated: true)
                self.locationManager.stopUpdatingLocation()
                mapView.showsUserLocation = false
                self.trackingLocation = false
            }
        }
    }
    
    // delegate that does all location management
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
}
