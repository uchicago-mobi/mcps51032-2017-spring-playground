//
//  InterfaceController.swift
//  WatchThis WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/1/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import WatchKit
import Foundation
import WatchInterfaceKit
import UserNotifications

class InterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {
  
  /// Array of Face objects of executives
  let faces = Faces().list
  
  //
  // MARK: - Outlets and Actions
  //
  @IBOutlet weak var headerLabel: WKInterfaceLabel!
  @IBOutlet weak var table: WKInterfaceTable!
  
  /// From a force touch, reset the favorite
  @IBAction func tapMenuTrash() {
    print("Tap Menu Trash")
    LocalDefaultsManager.sharedInstance.reset()
  }
  
  //
  // MARK: - Lifecycle
  //
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    
    // Configure interface objects here
    self.headerLabel.setText("Apple Executives")
    
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    // Load up the table
    reloadTable()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  
  //
  // MARK: - Notifications
  //
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()
    print(response.actionIdentifier)
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  
  
  //
  // MARK: - Table Support
  //
  func reloadTable() {
    table.setNumberOfRows(faces.count, withRowType: "FaceRow")
    
    // Go through our array of people and fill in the table
    for (index, _) in (faces).enumerated() {
      if let row = table.rowController(at: index) as? FaceRow {
        // Get the current face from the index
        let currentFace = faces[index]
        
        // Set the interface objects
        row.titleLabel.setText(currentFace.title)
        row.nameLabel.setText(currentFace.name)
        row.image.setImageNamed(currentFace.imageName)
      }
    }
  }
  
  // MARK: - Segue
  override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
    // Validate which segue we are triggering
    if segueIdentifier == "FaceDetailSegue" {
      // Get face from row index and return (to be used as context in
      // segue
      let name = faces[rowIndex].name
      return name
    }
    // Return nil as a fallback
    return nil
  }
  
  
  
  // Send a location notification
  func sendNotification() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    
    let content = UNMutableNotificationContent()
    content.title = "Hi"
    content.body = "Bye"
    content.sound = UNNotificationSound.default()
    content.categoryIdentifier = "myCategory"
    
    let category = UNNotificationCategory(identifier: "myCategory",
                                          actions: [],
                                          intentIdentifiers: [],
                                          options: [])
    center.setNotificationCategories([category])
    
    let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: TimeInterval(60),
                                                         repeats: false)
    let id = String(Date().timeIntervalSinceReferenceDate)
    let request = UNNotificationRequest.init(identifier: id, content: content, trigger: trigger)
    center.add(request)
  }
}
