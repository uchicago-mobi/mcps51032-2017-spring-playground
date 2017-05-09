//
//  ViewController.swift
//  CloudyWithAChanceOfErros
//
//  Created by T. Andrew Binkowski on 5/2/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {
  
  // MARK: - CloudKit
  let container: CKContainer = CKContainer.default()
  let publicDB: CKDatabase = CKContainer.default().publicCloudDatabase
  let privateDB: CKDatabase = CKContainer.default().privateCloudDatabase
  
  // The current user's record
  var userRecordID: CKRecordID?
  
  @IBAction func tapAdd(_ sender: UIButton) {
   CloudKitManager.sharedInstance.addJoke("Why did the student throw a clock out the window?",
             response:"She wanted to see time fly.")
  }
  
  @IBAction func tapQueryByUser(_ sender: UIButton) {
    if let userRecordID = self.userRecordID {
      CloudKitManager.sharedInstance.getJokesByCurrentUser(userRecordID)
    } else {
      print("No jokes...")
    }
  }
  
  @IBAction func tapQueryAll(_ sender: UIButton) {
    //CloudKitManager.sharedInstance.getJokes()
    
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "joke", predicate: predicate)
    CloudKitManager.sharedInstance.getJokesWithOperation(query: query, cursor: nil)
  }
  
  
  //
  // MARK: - Lifecycle
  //
  
  
  override func viewDidAppear(_ animated: Bool) {
    
    // Get the user
    CloudKitManager.sharedInstance.getUserRecordId { (recordID, error) in
      if let userID = recordID?.recordName {
        print("iCloudID: \(userID)")
        self.userRecordID = recordID
      } else {
        print("iCloudID: nil")
      }
    }
    
    CloudKitManager.sharedInstance.getUserIdentity { (record, error) in
      print(record)
    }
    
  }
  
}
