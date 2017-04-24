//
//  ViewController.swift
//  2016-ExtendThisApp
//
//  Created by T. Andrew Binkowski on 4/17/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit
import DataKit
import CoreData


class ViewController: UIViewController {
  
  var context: NSManagedObjectContext? {
    return CoreDataManager.sharedInstance.persistentContainer.viewContext
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let shortcut = UIApplicationShortcutItem(type: "mobi.uchicago.shortcuts.dynamic",
                                             localizedTitle: "😀Shortcut Title",
                                             localizedSubtitle: "Dynamic",
                                             icon: UIApplicationShortcutIcon(type: .add),
                                             userInfo: nil)
    UIApplication.shared.shortcutItems = [shortcut]
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    var person = Person(context: context!)
    person.name = "Homer"
    person.age = 42
    person.timestamp = Date() as NSDate
    
    person = Person(context: context!)
    person.name = "Marge2"
    person.age = 41
    person.timestamp =  Date() as NSDate
    
    CoreDataManager.sharedInstance.dump()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

