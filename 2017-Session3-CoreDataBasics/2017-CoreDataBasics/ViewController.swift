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
  
  
  @IBAction func tapAddPeople(_ sender: UIButton) {
    
    let person = Person(context: context!)
    person.name = UUID().uuidString
    person.age = 42
    person.timestamp = Date() as NSDate
    
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("HI")
    // Do any additional setup after loading the view, typically from a nib.
    
    
    var person = Person(context: context!)
    person.name = "Homer"
    person.age = 42
    person.timestamp = Date() as NSDate
    
    person = Person(context: context!)
    person.name = "Marge2"
    person.age = 41
    person.timestamp =  Date() as NSDate
    
    // 4
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Fetch our person objects
    let personFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()

    do {
      let fetchedEntities = try context?.fetch(personFetchRequest)
      
      for user in fetchedEntities! {
        print("> \(user.name!) ##########")
        //for session in user.sessions! {
        //  print(session)
        //}
      }
      
    } catch {
      // Do something in response to error condition
    }
  }
  
  
  
}

extension Person {
  func configured(name _name: String, age _age: Int) -> Self  {
    name = _name
    age = Int16(_age)
    return self
  }
}


