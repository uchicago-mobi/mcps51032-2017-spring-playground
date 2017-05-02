/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller demonstrates the various gesture types available in watchOS
 */
import WatchKit

class GestureDetailController : WKInterfaceController {
    @IBOutlet var tapGroup: WKInterfaceGroup!
    @IBOutlet var longPressGroup: WKInterfaceGroup!
    @IBOutlet var swipeGroup: WKInterfaceGroup!
    @IBOutlet var panGroup: WKInterfaceGroup!
    @IBOutlet var tapLabel: WKInterfaceLabel!
    @IBOutlet var longPressLabel: WKInterfaceLabel!
    @IBOutlet var swipeLabel: WKInterfaceLabel!
    @IBOutlet var panLabel: WKInterfaceLabel!
    var timer :Timer!
    
    @IBAction func tapRecognized(_ sender: AnyObject) {
        tapGroup.setBackgroundColor(UIColor.green)
        scheduleReset()
    }
    
    @IBAction func longPressRecognized(_ sender: AnyObject) {
        longPressGroup.setBackgroundColor(UIColor.green)
        scheduleReset()
    }
    
    @IBAction func swipeRecognized(_ sender: AnyObject) {
        swipeGroup.setBackgroundColor(UIColor.green)
        scheduleReset()
    }
    
    @IBAction func panRecognized(_ sender: AnyObject) {
        if let panGesture = sender as? WKPanGestureRecognizer {
            panGroup.setBackgroundColor(UIColor.green)
            panLabel.setText("offset: \(NSStringFromCGPoint(panGesture.translationInObject()))")
            scheduleReset()
        }
    }
    
    func scheduleReset() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(resetAllGroups), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func resetAllGroups() {
        tapGroup.setBackgroundColor(UIColor.clear)
        longPressGroup.setBackgroundColor(UIColor.clear)
        swipeGroup.setBackgroundColor(UIColor.clear)
        panGroup.setBackgroundColor(UIColor.clear)
    }
}
