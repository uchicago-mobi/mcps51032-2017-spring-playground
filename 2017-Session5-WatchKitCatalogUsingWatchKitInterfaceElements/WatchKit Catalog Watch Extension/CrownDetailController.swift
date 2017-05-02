/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller demonstrates the crown sequencer object and how it interacts with other scrolling components.
 */

import WatchKit

class CrownDetailController: WKInterfaceController, WKCrownDelegate {
    @IBOutlet var velocityLabel: WKInterfaceLabel!
    @IBOutlet var stateLabel: WKInterfaceLabel!
    @IBOutlet var pickerView: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let itemList: [(String, String)] = [
            ("Item 1", "Red"),
            ("Item 2", "Green"),
            ("Item 3", "Blue")
        ]
        let pickerItems: [WKPickerItem] = itemList.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = $0.0
            pickerItem.title = $0.1
            return pickerItem
        }
        pickerView.setItems(pickerItems)
        
        crownSequencer.delegate = self
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        crownSequencer.focus()
    }
    
    @IBAction func focusCrown(sender: AnyObject) {
        crownSequencer.focus()
    }
    
    func updateCrownLabels() {
        velocityLabel.setText(String(format: "RPS: %2.2lf", crownSequencer.rotationsPerSecond))
        stateLabel.setText(crownSequencer.isIdle ? "Idle: true" : "Idle: false")
    }
    
    func crownDidBecomeIdle(_ crownSequencer: WKCrownSequencer?) {
        updateCrownLabels()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        updateCrownLabels()
    }

}
