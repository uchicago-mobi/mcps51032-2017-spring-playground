/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays buttons and shows use of groups within buttons. This also demonstrates how to hide and show UI elements at runtime.
 */

import WatchKit

class ButtonDetailController: WKInterfaceController {
    @IBOutlet var defaultButton :WKInterfaceButton!
    @IBOutlet var hiddenButton :WKInterfaceButton!
    @IBOutlet var placeholderButton :WKInterfaceButton!
    @IBOutlet var alphaButton :WKInterfaceButton!
    var hidden :Bool
    var placeholderAlpha :CGFloat
    
    override init() {
        hidden = false
        placeholderAlpha = 1.0
    }
    
    @IBAction func hideAndShow() {
        placeholderButton.setHidden(!hidden)
        hidden = !hidden
    }
    
    @IBAction func changeAlpha() {
        placeholderButton.setAlpha(placeholderAlpha == 1.0 ? 0.0 : 1.0)
        placeholderAlpha = (placeholderAlpha == 1.0 ? 0.0 : 1.0)
    }

}
