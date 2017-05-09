//
//  CloudKitManager.swift
//  CloudyWithAChanceOfErrors
//
//  Created by T. Andrew Binkowski on 5/3/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

open class CloudKitManager {
  
  open static let sharedInstance = CloudKitManager()
  
  // MARK: - CloudKit
  let container: CKContainer = CKContainer.default()
  let publicDB: CKDatabase = CKContainer.default().publicCloudDatabase
  let privateDB: CKDatabase = CKContainer.default().privateCloudDatabase
  
  /// Current user
  var userRecordID: CKRecordID?
  
  // Keep it safe
  private init() {}
  
  
  //
  // MARK: - User Records
  //
  
  
  /// Get the users `RecordId`
  /// - parameters complete: A completion block passing two parameters
  open func getUserRecordId(complete: @escaping (CKRecordID?, NSError?) -> ()) {
    
    let container = CKContainer.default()
    container.fetchUserRecordID() {
      recordID, error in
      
      if error != nil {
        print(error!.localizedDescription)
        complete(nil, error as NSError?)
      } else {
        // We have access to the user's record
        print("fetched ID \(recordID?.recordName ?? "")")
        complete(recordID, nil)
      }
    }
  }
  
  /// Get the users `RecordId`
  /// - parameters complete: A completion block passing two parameters
  open func getUserIdentity(complete: @escaping (String?, NSError?) -> ()) {
    
    container.requestApplicationPermission(.userDiscoverability) { (status, error) in
      self.container.fetchUserRecordID { (record, error) in
        
        if error != nil {
          print(error!.localizedDescription)
          complete(nil, error as NSError?)
          
        } else {
          //print("fetched ID \(record?.recordName ?? "")")
          self.container.discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userID, error) in
            let userName = (userID?.nameComponents?.givenName)! + " " + (userID?.nameComponents?.familyName)!
            print("CK User Name: " + userName)
            complete(userName,nil)
          })
        }
      }
    }
  }
  
  
  //
  // MARK: - Modify/Create Records
  //
  
  
  /// Create a joke record and save to iCloud using CloudKit
  /// - parameter joke: Funny string
  /// - remark: Error handling leaves something to be desired
  func addJoke(_ joke: String, response: String) {
    
    let record = CKRecord(recordType: "joke")
    record.setValue(joke, forKey: "question")
    record["response"] = response as CKRecordValue
    record["rating_positive"] = 0 as CKRecordValue
    record["rating_negative"] = 0 as CKRecordValue
    
    publicDB.save(record) { (record, error) in
      if let error = error {
        print("Error: \(error.localizedDescription)")
        return
      }
      print("Saved record: \(record.debugDescription)")
    }
  }
  
  
  //
  // MARK: - Queries
  //
  open func getRecordById(_ recordId: CKRecordID,
                          completion: @escaping (CKRecord?, NSError?) -> ()) {
    publicDB.fetch(withRecordID: recordId) { (record, error) in
      if let error = error {
        print("Error: \(String(describing: error.localizedDescription))")
        completion(nil, error as NSError?)
      }
      if let record = record {
        print(record.description)
        completion(record, nil)
      }
    }
    
  }
  
  /// Get all jokes by a user
  /// - parameter recordID: The `CKRecordID` of the current user
  open func getJokesByCurrentUser(_ recordID: CKRecordID) {
    
    // The user is a reference, so we need to query against a reference
    let reference = CKReference(recordID: recordID, action: .none)
    
    
    let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
    
    let query = CKQuery(recordType: "joke", predicate: predicate)
    publicDB.perform(query, inZoneWith: nil) { (records, error) -> Void in
      if let error = error {
        print("Error: \(String(describing: error.localizedDescription))")
        return
      }
      for record in records! {
        print(record["question"] as! String)
      }
    }
  }
  
  
  /// Get all jokes in the public database
  open func getJokes() {
    let predicate = NSPredicate(format: "TRUEPREDICATE")
    
    let query = CKQuery(recordType: "joke", predicate: predicate)
    publicDB.perform(query, inZoneWith: nil) { (records, error) -> Void in
      if let error = error {
        print("Error: \(String(describing: error.localizedDescription))")
        return
      }
      for record in records! {
        print("😂: \(record["question"] as! String)")
      }
    }
  }
  
  
  /// Use the operation API to make a query and use cursors
  /// to control the folow of data
  /// - parameter query: A `CKQuery?`, most likely represents the initial query
  open func getJokesWithOperation(query: CKQuery?, cursor: CKQueryCursor?) {
    var queryOperation: CKQueryOperation!
    
    if query != nil {
      let predicate = NSPredicate(value: true)
      let query = CKQuery(recordType: "joke", predicate: predicate)
      queryOperation = CKQueryOperation(query: query)
    } else if let cursor = cursor {
      print("== Cursor ======================================================")
      queryOperation = CKQueryOperation(cursor: cursor)
    }
    
    // Query parameters
    //queryOperation.desiredKeys = ["", "", ""]
    queryOperation.queuePriority = .veryHigh
    queryOperation.resultsLimit = 5
    queryOperation.qualityOfService = .userInteractive
    
    // This gets called each time per record
    queryOperation.recordFetchedBlock = {
      (record: CKRecord!) -> Void in
      if record != nil {
        print("😂 operation: \(record["question"] as! String)")
      }
    }
    
    // This is called after all records are retrieved and iterated
    // on
    queryOperation.queryCompletionBlock = { cursor, error in
      if (error != nil) {
        print("Error:\(String(describing: error))")
        return
      }
      
      if let cursor = cursor {
        print("There is more data to fetch")
        self.getJokesWithOperation(query: nil, cursor: cursor)
        
        print("Done with opeartion...")
        //OperationQueue.main.addOperation() {
        // Do anything else with the record after downloaded that
        // needs to be on the main thread
        //}
      }
    }
    self.publicDB.add(queryOperation)
  }
  
  
  //
  // MARK: - Subscriptions
  //
  
  
  func registerSubscriptionsWithIdentifier(_ identifier: String) {
    
    let uuid: UUID = UIDevice().identifierForVendor!
    let identifier = "\(uuid)-creation"
    
    // Create the notification that will be delivered
    let notificationInfo = CKNotificationInfo()
    notificationInfo.alertBody = "A new joke was added."
    notificationInfo.shouldBadge = true
    notificationInfo.shouldSendContentAvailable = true
    
    let subscription = CKQuerySubscription(recordType: "joke",
                                           predicate: NSPredicate(value: true),
                                           subscriptionID: identifier,
                                           options: [.firesOnRecordCreation])
    subscription.notificationInfo = notificationInfo
    CKContainer.default().publicCloudDatabase.save(subscription, completionHandler: ({returnRecord, error in
      if let err = error {
        print("subscription failed \(err.localizedDescription)")
      } else {
        print("subscription set up")
      }
    }))
  }
  
  func registerSilentSubscriptionsWithIdentifier(_ identifier: String) {
    
    let uuid: UUID = UIDevice().identifierForVendor!
    let identifier = "\(uuid)-delete"
    
    // Create the notification that will be delivered
    let notificationInfo = CKNotificationInfo()
    notificationInfo.shouldSendContentAvailable = true
    
    let subscription = CKQuerySubscription(recordType: "joke",
                                           predicate: NSPredicate(value: true),
                                           subscriptionID: identifier,
                                           options: [.firesOnRecordCreation])
    subscription.notificationInfo = notificationInfo
    CKContainer.default().publicCloudDatabase.save(subscription, completionHandler: ({returnRecord, error in
      if let err = error {
        print("subscription failed \(err.localizedDescription)")
      } else {
        print("subscription set up")
      }
    }))
  }
  
  
  
}
