/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays sliders and their various configurations.
 */

import WatchKit

class SliderDetailController: WKInterfaceController {
    @IBOutlet var coloredSlider :WKInterfaceSlider!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        coloredSlider.setColor(UIColor.red)
    }
}
