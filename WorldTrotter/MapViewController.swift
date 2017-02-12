//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Tom Liu's Mac on 2/7/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func loadView() {
        //create a map view through programming
        mapView = MKMapView()
        
        //set it as *the* of this view controller
        view = mapView
        //add delegate for silver challenge2w
        mapView.delegate = self
        locationManager = CLLocationManager()
        
        let segmentedControl
            = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
        initLocalizationButton(segmentedControl)
        
        //Page 109 Anchors
        //each anchor of segmented control should be equal to its anchor of subview
        let topConstraint
            = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant:8 )
        let margins = view.layoutMarginsGuide
        let leadingConstraint
            = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint
            = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //Where to put this code?
        self.mapView.delegate = self   //in delegate
        mapView.delegate = self
        
    }
    
    
    //self.mapView.userLocation(sender: click(hybrid))
    //mpView.showUserLocation = true

    //initialize the my location Button
    func initLocalizationButton(_ anyView: UIView!){
        let localizationButton = UIButton.init(type: .system)
        localizationButton.setTitle("My Locationn", for: .normal)
        localizationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(localizationButton)
        
        //Constraints
        
        let topConstraint = localizationButton.topAnchor.constraint(equalTo:anyView
            .topAnchor, constant: 32 )
        let leadingConstraint = localizationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = localizationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        localizationButton.addTarget(self, action: #selector(MapViewController.showLocalization(sender:)), for: .touchUpInside)
        
        
    }
    func showLocalization(sender: UIButton!){
        locationManager.requestWhenInUseAuthorization()//se agrega permiso en info.plist
        mapView.showsUserLocation = true //fire up the method mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
        
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //This is a method from MKMapViewDelegate, fires up when the user`s location changes
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
    }
    
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print("Start locating")
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        print("Stop Locating")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl){
    
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
            mapView.showsUserLocation = true
        case 2:
            mapView.mapType = .satellite
            mapView.showsUserLocation = false
        default:
            break
        }
    }
    

    
    
    
}

