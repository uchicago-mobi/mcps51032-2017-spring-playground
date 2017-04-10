//
//  ViewController.swift
//  2016-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/3/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //
  // MARK: - Lifecycle
  //
  

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Load up the defaults and print them the console (we should be able to see
    // that we changed the values from Objectice-C
    let defaults = UserDefaults.standard
    print("Defaults (from Swift ViewController:\n \(defaults.dictionaryRepresentation())")
    
    // Call our objective-c code
    let message = GreetingObject(message: "This is from Swift")
    message?.greetWithDate()
    
  }
  
}

