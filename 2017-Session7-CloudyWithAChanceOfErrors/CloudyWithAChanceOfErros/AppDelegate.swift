//
//  AppDelegate.swift
//  CloudyWithAChanceOfErros
//
//  Created by T. Andrew Binkowski on 5/2/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import UserNotifications
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Set the notification delegate
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      if let error = error {
        print("Error: \(error.localizedDescription)")
      } else {
        application.registerForRemoteNotifications()
      }
    }
    UNUserNotificationCenter.current().delegate = self

    // Register subscriptions
    CloudKitManager.sharedInstance.registerSubscriptionsWithIdentifier("id2")
    CloudKitManager.sharedInstance.registerSilentSubscriptionsWithIdentifier("id3")
    //configureUserNotificationsCenter()
    
    // Parse the launch notification so that we can get the payload
    if let notification = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
      let aps = notification["aps"] as! [String: AnyObject]
      print("APS: \(aps)")

      // You could do something here to change the view controller on the screen programatically
      //(window?.rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    return true
  }
  
  
  //
  // MARK: - Notifications
  //
  
  /*
   /// Set up notification actions
   func configureUserNotificationsCenter() {
   // Configure User Notification Center
   
   // Define Actions
   let actionReadLater = UNNotificationAction(identifier: "action1", title: "Read Later", options: [])
   let actionShowDetails = UNNotificationAction(identifier: "action2", title: "Show Details", options: [.foreground])
   let actionUnsubscribe = UNNotificationAction(identifier: "action3", title: "Unsubscribe", options: [.destructive, .authenticationRequired])
   
   // Define Category
   let tutorialCategory = UNNotificationCategory(identifier: "ActionCategory", actions: [actionReadLater, actionShowDetails, actionUnsubscribe], intentIdentifiers: [], options: [])
   
   // Register Category
   UNUserNotificationCenter.current().setNotificationCategories([tutorialCategory])
   }
   */
  

  /// Show notification when app is in foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert,.badge,.sound])
  }
  
  
  /// Called for push notifications
  /// In this case, we are getting the changed record from cloudkit and then creating a new notification
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
    let aps = userInfo["aps"] as! [String: AnyObject]
    print("APS: \(aps)")
    
    let contentAvailable = aps["content-available"] as! Int
    if contentAvailable == 1 {
    
      
      // Pull data
      let cloudKitInfo = userInfo["ck"] as! [String: AnyObject]

      // Get the record id
      let rid = cloudKitInfo["qry"]?["rid"] as! String
      let ckrid = CKRecordID(recordName: rid)
      
      // Get the cloudkit record (by id)
      CloudKitManager.sharedInstance.getRecordById(ckrid, completion: { (record, error) in
        print(record)

        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = (record?.description)!
        content.sound = UNNotificationSound.default()

        // Set up trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5,repeats: false)
        
        
        // Create the notification request
        let center = UNUserNotificationCenter.current()
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
          if let error = error {
            // Something went wrong
          }
        })

        
        completionHandler(.newData)
      })

    } else {
      completionHandler(.noData)
    }
  }
  

  /// Called when user taps on a notifiction or a specific action button
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    
    
    let response = response.notification.request.content
    print("Notification: \(response)")
    //    switch response.actionIdentifier {
    //    case Notification.Action.readLater:
    //      print("Save Tutorial For Later")
    //    case Notification.Action.unsubscribe:
    //      print("Unsubscribe Reader")
    //    default:
    //      print("Other Action")
    //    }
    
    completionHandler()
  }
}
