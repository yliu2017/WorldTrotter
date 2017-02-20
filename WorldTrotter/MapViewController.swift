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
    var defaultSpan = MKCoordinateSpanMake(60.0,60.0)
    var defaultLoc = CLLocationCoordinate2DMake(39,-100)
    
    //default loc and defalut region
    func goDefaultLocation()
    {
        
        let defaultRegion = MKCoordinateRegionMake(defaultLoc, defaultSpan)
        mapView.setCenter(defaultLoc, animated: true)
        mapView.setRegion(defaultRegion, animated: true)
    }
    
    let span = MKCoordinateSpanMake(0.002,0.002)  //default span for pin
   
    
    override func loadView() {
        //create a map view through programming
        mapView = MKMapView()
        
        //set it as *the* of this view controller
        view = mapView
        //add delegate for silver challenge2w
        mapView.delegate = self
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl
            = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        //load segementControl
        view.addSubview(segmentedControl)
        
        //load location button
        initLocalizationButton(segmentedControl)
        //load pin button
        initPinsButton(segmentedControl)
        
        
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
 
    }
    
    
    //self.mapView.userLocation(sender: click(hybrid))
    //mpView.showUserLocation = true

    //initialize the my location Button
    func initLocalizationButton(_ anyView: UIView!){
        let localizationButton = UIButton.init(type: .roundedRect)
        localizationButton.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        localizationButton.setTitle("Locate Me", for: .normal)
        localizationButton.translatesAutoresizingMaskIntoConstraints = false
        localizationButton.frame.size.width = 150
        localizationButton.frame.size.height = 50
        localizationButton.layer.borderWidth = 1
        localizationButton.layer.cornerRadius = 5
        localizationButton.layer.borderColor = UIColor.blue.cgColor
        
        view.addSubview(localizationButton)
        
        //Constraints
        
        let bottomConstraint = localizationButton.bottomAnchor.constraint(equalTo:bottomLayoutGuide.topAnchor, constant: -8)
        let leadingConstraint = localizationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        
        
        localizationButton.addTarget(self, action: #selector(MapViewController.showLocalization(sender:)), for: .touchUpInside)
        localizationButton.addTarget(self, action: #selector(MapViewController.showLocalization(sender:)), for: .touchDownRepeat)
        
        
    }
    
    func initPinsButton(_ anyView: UIView!){
        let pinsButton = UIButton.init(type: .roundedRect)
        pinsButton.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        pinsButton.setTitle("Pins", for: .normal)
        pinsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinsButton)
        pinsButton.frame.size.width = 150
        pinsButton.frame.size.height = 50
        pinsButton.layer.borderWidth = 1
        pinsButton.layer.cornerRadius = 5
        pinsButton.layer.borderColor = UIColor.blue.cgColor
        
        //Constraints
        
        let bottomConstraint = pinsButton.bottomAnchor.constraint(equalTo:bottomLayoutGuide.topAnchor, constant: -8)
        let trailingConstraint = pinsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        bottomConstraint.isActive = true
        trailingConstraint.isActive = true
        
        pinsButton.addTarget(self, action: #selector(MapViewController.showPins(sender:)), for: .touchUpInside)

        
    }
    
    var locButtonClickIndex:Int = 0;
    func showLocalization(sender: UIButton!){
        locButtonClickIndex = locButtonClickIndex % 2
        locationManager.requestWhenInUseAuthorization()// info.plist
        if locButtonClickIndex % 2 == 0{
            mapView.showsUserLocation = true //fire up the method mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation)
        }
        else{
            mapView.showsUserLocation = false
            goDefaultLocation()
            
        }
        print("loc click index = " + "\(locButtonClickIndex)")
        locButtonClickIndex += 1
        
    }
        let pin0 = MKPointAnnotation()
        let pin1 = MKPointAnnotation()
        let pin2 = MKPointAnnotation()
    
    
    var pinindex: Int = 0
    func showPins(sender: UIButton!){
        pin0.coordinate = CLLocationCoordinate2DMake(39.916553,116.252220)  // pin to my born place
        pin1.coordinate = CLLocationCoordinate2DMake(35.986636, -80.003877)  // pin to my dorm
        pin2.coordinate = CLLocationCoordinate2DMake(38.897641, -77.036549)  // pin to white house
        pin0.title = "HangTian Hospital,HaiDian,Beijing,China"
        pin1.title = "North College Terrace,High Point,NC"
        pin2.title = "White House,DC"
    
        
        //my pin function process the pinindex and showsuserLocation to determin what to set the current location
        pinindex = (pinindex + 1) % 4 //cycle throught 0-4
        locButtonClickIndex = 0
        if pinindex == 1{
            //let thisRegion = MKCoordinateRegionMake(pin0.coordinate, span)
            mapView.setCenter(pin0.coordinate, animated: true)
            //mapView.setRegion(thisRegion, animated: true)
            mapView.addAnnotation(pin0)
            mapView.removeAnnotation(pin1)
            mapView.removeAnnotation(pin2)
        }
        else if pinindex == 2{
            //let thisRegion = MKCoordinateRegionMake(pin1.coordinate, span)
            mapView.setCenter(pin1.coordinate, animated: true)
            //mapView.setRegion(thisRegion, animated: true)
            mapView.addAnnotation(pin1)
            mapView.removeAnnotation(pin0)
            mapView.removeAnnotation(pin2)
        }
        else if pinindex == 3{
           // let thisRegion = MKCoordinateRegionMake(pin2.coordinate, span)
            mapView.setCenter(pin2.coordinate, animated: true)
          //  mapView.setRegion(thisRegion, animated: true)
            mapView.addAnnotation(pin2)
            mapView.removeAnnotation(pin0)
            mapView.removeAnnotation(pin1)
        }
        else{
            //remove the pins and go to default location
            mapView.removeAnnotation(pin0)
            mapView.removeAnnotation(pin1)
            mapView.removeAnnotation(pin2)
            goDefaultLocation()
        }
        
        
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
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        defaultSpan = mapView.region.span
        let latitude = mapView.region.center.latitude
        let longitude = mapView.region.center.longitude
        if !(latitude == pin0.coordinate.latitude||latitude == pin1.coordinate.latitude||latitude == pin1.coordinate.latitude){
            if !(longitude == pin0.coordinate.longitude||longitude == pin1.coordinate.longitude||longitude == pin1.coordinate.longitude){
                defaultLoc = mapView.region.center
                print("New default setting assigned.")
            }
        }
        print("regionDidChangeAnimated called")
    }
    
    
    
}

