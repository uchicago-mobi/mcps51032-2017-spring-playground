//
//  FaceDetailController.swift
//  WatchInterface
//
//  Created by T. Andrew Binkowski on 5/18/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation
import WatchKit
import WatchInterfaceKit

class FaceDetailController: WKInterfaceController {
    
    /// Store the name explicitly since we can't get it from the labels
    var cachedName: String = ""
  
    //
    // MARK: - Outlets and Actions
    //
    @IBOutlet weak var name: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var positionTitle: WKInterfaceLabel!
    
    /// Add current user as favorite
    @IBAction func tapFavorite() {
        LocalDefaultsManager.sharedInstance.add(object: cachedName as NSObject)
    }
    
    // MARK: - Lifecycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        cachedName = context as! String        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.name.setText(cachedName)
        self.image.setImageNamed(cachedName)
        self.positionTitle.setText("")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
