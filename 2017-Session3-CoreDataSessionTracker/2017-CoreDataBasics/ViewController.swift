//
//  ViewController.swift
//  2017-CoreDataBasics
//
//  Created by T. Andrew Binkowski on 4/16/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  var context: NSManagedObjectContext? {
    return (UIApplication.shared.delegate as? AppDelegate)?
      .persistentContainer.viewContext
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create some people
    let user1 = User(context: context!)
    user1.name = "Homer"
    user1.age = 42
    user1.timestamp = Date() as NSDate
    
    // Create some people
    let user2 = User(context: context!)
    user2.name = "Marge"
    user2.age = 42
    user2.timestamp = Date() as NSDate
    
    // Let's create a bunch sessesions and add them to difference users
    for i in 0...10 {
      let session = Session(context: context!)
      // Just for fun, make the even sessions true
      session.active = (i % 2 == 0) ? true : false
      session.timestamp = Date() as NSDate
      session.user = user2
      session.user = user1
    }
    
    // Save
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    (UIApplication.shared.delegate as? AppDelegate)?.dump()
  }
  
  
  @IBAction func tapAddPeople(_ sender: UIButton) {
    
    let person = User(context: context!)
    person.name = "Random Person"
    person.age = 42
    person.timestamp = Date() as NSDate
    
    let session = Session(context: context!)
    session.active = true
    session.timestamp = Date() as NSDate
    session.user = person
    
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
}

