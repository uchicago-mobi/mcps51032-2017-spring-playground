/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller represents a single page of the modal page-based navigation controller, presented in ControllerDetailController.
 */

import WatchKit

class PageController: WKInterfaceController {
    @IBOutlet var pageLabel :WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        pageLabel.setText(String(format:"%@ Page", context as! NSDictionary))
    }
}
