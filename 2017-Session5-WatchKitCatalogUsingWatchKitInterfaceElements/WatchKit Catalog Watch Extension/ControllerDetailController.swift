/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller demonstrates how to present a modal controller with a page-based navigation style. By performing a Force Touch gesture on the controller (click-and-hold in the iOS Simulator), you can present a menu.
 */

import WatchKit

class ControllerDetailController: WKInterfaceController {
    
    @IBAction func presentPages() {
        let controllerNames = ["pageController", "pageController", "pageController", "pageController", "pageController"]
        let contexts = ["First", "Second", "Third", "Fourth", "Fifth"]
        
        presentController(withNames: controllerNames, contexts: contexts)
    }
    
    @IBAction func menuItemTapped() {
        print("A menu item was tapped.")
    }
    
}
