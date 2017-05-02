/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller handles displaying a custom or static notification.
 */

import WatchKit
import UserNotifications

class NotificationController : WKUserNotificationInterfaceController {
    
    override func willActivate() {
        // This method is called when the controller is about to be visible to the wearer.
        print("\(self) will activate")
    
        updateUserActivity("com.example.apple-samplecode.WatchKit-Catalog.notification", userInfo: ["Reason" : "Notification"], webpageURL: nil)
    }
    
    override func handleAction(withIdentifier identifier: String?, for notification: UNNotification) {
        print("notification received with identifier: \(identifier), notifiction: \(notification)")
    }
}
