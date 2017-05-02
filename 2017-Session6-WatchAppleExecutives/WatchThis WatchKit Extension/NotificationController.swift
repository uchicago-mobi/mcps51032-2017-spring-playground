//
//  NotificationController.swift
//  WatchThis WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/1/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationController: WKUserNotificationInterfaceController {
  
  @IBOutlet var messageLabel: WKInterfaceLabel!
  @IBOutlet var faceImage: WKInterfaceImage!
  
  override init() {
    super.init()
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  

  // Handle the notifications that come in
  override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    
    print("Received notification: \(notification)")
    
    // After populating your dynamic notification interface call the completion block.
    messageLabel.setText(notification.request.content.body)
    completionHandler(.custom)
  }
  
}
