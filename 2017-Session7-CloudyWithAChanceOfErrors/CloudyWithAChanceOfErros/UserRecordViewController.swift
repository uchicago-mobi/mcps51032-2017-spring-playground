//
//  UserRecordViewController.swift
//  CloudyWithAChanceOfErrors
//
//  Created by T. Andrew Binkowski on 5/3/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CloudKit

class UserRecordViewController: UIViewController {
  
  // MARK: - CloudKit
  let container: CKContainer = CKContainer.default()
  let publicDB: CKDatabase = CKContainer.default().publicCloudDatabase
  
  var userRecordID: CKRecordID?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getUserRecordId { (recordID, error) in
      if let userID = recordID?.recordName {
        print("iCloudID: \(userID)")
        self.userRecordID = recordID
        //self.getJokesByCurrentUser(recordID!)
      } else {
        print("iCloudID: nil")
      }
    }
    
    getUserIdentity { (userIdentity, error) in
      if let userID = userIdentity {
        print("iCloud UserId: \(userID)")
      } else {
        print("iCloudID UserId: nil")
      }
    }
  }
  
  
  /// Get the users `RecordId`
  /// - parameters complete: A completion block passing two parameters
  func getUserRecordId(complete: @escaping (CKRecordID?, NSError?) -> ()) {
    
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
  func getUserIdentity(complete: @escaping (String?, NSError?) -> ()) {
    
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
}

