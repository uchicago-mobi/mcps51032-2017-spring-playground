//
//  ViewController.swift
//  WatchYourBack
//
//  Created by T. Andrew Binkowski on 5/7/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class BackgroundFetchViewController: UIViewController {
  
  var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .long
    return formatter
  }()
  
  @IBOutlet weak var timeLabel: UILabel!
  
  var currentTime: Date? {
    didSet {
      if let currentTime = self.currentTime {
        self.timeLabel.text = dateFormatter.string(from: currentTime)
      }
    }
  }
  
  //
  // MARK: -
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    self.updateInterface()
  }
  
  // 
  // MARK: - Fetching and Updating
  //
  func fetchData(_ completion: () -> Void) {
    // Some long running task
    for i in 0...100 {
      print(i)
    }
    completion()
  }
  
  func updateInterface() {
    print("UpdateUI")
    self.currentTime = Date()
  }
}


