/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays device specific information to use for ensuring a great experience to the wearer of the WatchKit app.
 */

import WatchKit

class DeviceDetailController: WKInterfaceController {
    @IBOutlet var boundsLabel :WKInterfaceLabel!
    @IBOutlet var scaleLabel :WKInterfaceLabel!
    @IBOutlet var preferredContentSizeLabel :WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let bounds = WKInterfaceDevice.current().screenBounds
        let scale = WKInterfaceDevice.current().screenScale
        
        boundsLabel.setText(NSStringFromCGRect(bounds))
        scaleLabel.setText(NSString(format:"%f",scale) as String)
        preferredContentSizeLabel.setText(WKInterfaceDevice.current().preferredContentSizeCategory)
    }
}
