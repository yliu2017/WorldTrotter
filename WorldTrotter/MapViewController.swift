//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Tom Liu's Mac on 2/7/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view")
        
    }

    
    
}

