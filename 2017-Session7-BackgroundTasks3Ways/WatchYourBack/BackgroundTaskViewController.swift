//
//  BackgroundTaskViewController.swift
//  WatchYourBack
//
//  Created by T. Andrew Binkowski on 5/8/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class BackgroundTaskViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    longRunningTask()
  }
  
  func longRunningTask() {
    var bti : UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    bti = UIApplication.shared.beginBackgroundTask(expirationHandler: {
      // Clean up after run (or denial)

      // Call the completion handler
      UIApplication.shared.endBackgroundTask(bti)
    })
    
    // Do work
    for i in 0...100000000 {
      print(i)
    }
    
    DispatchQueue.main.async {
      UIApplication.shared.endBackgroundTask(bti)
    }
  }
}
