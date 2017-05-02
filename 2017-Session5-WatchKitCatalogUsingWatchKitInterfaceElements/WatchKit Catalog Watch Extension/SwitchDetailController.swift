/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays switches and their various configurations.
 */

import WatchKit

class SwitchDetailController: WKInterfaceController {
    @IBOutlet var offSwitch :WKInterfaceSwitch!
    @IBOutlet var coloredSwitch :WKInterfaceSwitch!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        offSwitch.setOn(false)
        
        coloredSwitch.setColor(UIColor.blue)
        coloredSwitch.setTitle("Blue Switch")
    }
}
