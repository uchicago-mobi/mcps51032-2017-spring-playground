/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays a map and demonstrates use of setting its coordinate region, zoom level, and addition and removal of annotations.
 */

import WatchKit

class MapDetailController: WKInterfaceController {
    @IBOutlet var map :WKInterfaceMap!
    var currentRegion :MKCoordinateRegion
    var currentSpan :MKCoordinateSpan
    
    @IBOutlet var appleButton :WKInterfaceButton!
    @IBOutlet var tokyoButton :WKInterfaceButton!
    @IBOutlet var inButton :WKInterfaceButton!
    @IBOutlet var outButton :WKInterfaceButton!
    @IBOutlet var pinsButton :WKInterfaceButton!
    @IBOutlet var imagesButton :WKInterfaceButton!
    @IBOutlet var removeAllButton :WKInterfaceButton!
    
    override init() {
        currentSpan = MKCoordinateSpanMake(1.0, 1.0)
        currentRegion = MKCoordinateRegionForMapRect(MKMapRectMake(0, 0, 1.0, 1.0))
    }
    
    @IBAction func goToTokyo() {
        let coordinate = CLLocationCoordinate2DMake(35.4, 139.4)
        setMapTo(coordinate: coordinate)
    }
    
    @IBAction func goToApple() {
        let coordinate = CLLocationCoordinate2DMake(37.331793, -122.029584)
        setMapTo(coordinate: coordinate)
    }
    
    func setMapTo(coordinate :CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMake(coordinate, currentSpan)
        currentRegion = region;
        
        let newCenterPoint = MKMapPointForCoordinate(coordinate)
        
        map.setVisibleMapRect(MKMapRectMake(newCenterPoint.x, newCenterPoint.y, currentSpan.latitudeDelta, currentSpan.longitudeDelta))
        map.setRegion(region)
    }
    
    @IBAction func zoomOut() {
        let span = MKCoordinateSpanMake(currentSpan.latitudeDelta * 2, currentSpan.longitudeDelta * 2)
        let region = MKCoordinateRegionMake(currentRegion.center, span)
    
        currentSpan = span
        map.setRegion(region)
    }
    
    @IBAction func zoomIn() {
        let span = MKCoordinateSpanMake(currentSpan.latitudeDelta * 0.5, currentSpan.longitudeDelta * 0.5)
        let region = MKCoordinateRegionMake(currentRegion.center, span)
    
        currentSpan = span
        map.setRegion(region)
    }
    
    @IBAction func addPinAnnotations() {
        map.addAnnotation(currentRegion.center, with: .red)
    
        let greenCoordinate = CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude - 0.3)
        map.addAnnotation(greenCoordinate, with:.green)
    
        let purpleCoordinate = CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude + 0.3)
        map.addAnnotation(purpleCoordinate, with:.purple)
    }
    
    @IBAction func addImageAnnotations() {
        let firstCoordinate = CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude - 0.3)
    
        // Uses image in WatchKit app bundle.
        map.addAnnotation(firstCoordinate, with: UIImage(named:"Whale"), centerOffset: CGPoint.zero)
    
        let secondCoordinate = CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude + 0.3)
    
        // Uses image in WatchKit Extension bundle.
        let image = UIImage(named:"Bumblebee")
        map.addAnnotation(secondCoordinate, with:image, centerOffset:CGPoint.zero)
    }
    
    @IBAction func removeAll() {
        map.removeAllAnnotations()
    }
}
