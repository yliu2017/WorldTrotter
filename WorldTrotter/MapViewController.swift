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
        
        let segmentedControl
            = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
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

