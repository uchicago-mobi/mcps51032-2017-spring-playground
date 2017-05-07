//
//  InterfaceController.swift
//  WatchThisMap WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/7/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class InterfaceController: WKInterfaceController {
  
  @IBOutlet var map: WKInterfaceMap!
  
  var locationManager: CLLocationManager = CLLocationManager()
  var mapLocation: CLLocationCoordinate2D?
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Get the current location (update the map in the delegate)
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.delegate = self
    
    // Comment this out to show
    //locationManager.requestLocation()
    
    // Set a  default location (the watch loads notoriously slowly).  It may 
    // be better to show a map (even if its the wrong location) than no map, 
    // so that users continue to interact with the watch and keep it awake
    let location = CLLocationCoordinate2DMake(37, -122)
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    let region = MKCoordinateRegion(center: location, span: span)
    // Default pin is green (so we can evaluate the loading); current location is purple
    self.map.addAnnotation(location, with: .green)
    
    self.map.setRegion(region)
  }
}

///
///
///
extension InterfaceController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation = locations[0]
    let lat = currentLocation.coordinate.latitude
    let long = currentLocation.coordinate.longitude
    
    self.mapLocation = CLLocationCoordinate2DMake(lat, long)
    
    let span = MKCoordinateSpanMake(0.1, 0.1)
    
    let region = MKCoordinateRegionMake(self.mapLocation!, span)
    self.map.setRegion(region)
    
    self.map.addAnnotation(self.mapLocation!, with: .purple)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }
  
}
