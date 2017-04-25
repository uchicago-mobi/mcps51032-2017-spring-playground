//
//  CoreDataManager.swift
//  2017-ExtendThisApp
//
//  Created by T. Andrew Binkowski on 4/23/17.
//  Copyright © 2017 The University of Chicago, Department of Computer Science. All rights reserved.
//

import Foundation
import CoreData


// We need to override the default location of the core data store
// to use the app groups
final class PersistentContainer: NSPersistentContainer {
  //
  internal override class func defaultDirectoryURL() -> URL {
    var url = super.defaultDirectoryURL()
    if let newURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: DataKitConstants.applicationGroupIdentifier) {
      url = newURL
    }
    return url
  }
  
  override init(name: String, managedObjectModel model: NSManagedObjectModel) {
    super.init(name: name, managedObjectModel: model)
  }
}


public class CoreDataManager {
  
  public static let sharedInstance = CoreDataManager()
  
  /*
  var managedObjectModel: NSManagedObjectModel = {
    // The managed object model for the application. This property is not optional. It is a fatal error
    // for the application not to be able to find and load its model.
    let kitBundle = Bundle(identifier: "group.2017-extend-this-app")
    
    
    
    let modelURL = kitBundle?.url(forResource: "Model", withExtension: "momd")
    
    return NSManagedObjectModel(contentsOf: modelURL!)!
  }()
  */

  // MARK: - Core Data stack
  lazy public var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    
    let kitBundle = Bundle(identifier: "mobi.uchicago.DataKit")
    let modelURL = kitBundle?.url(forResource: "Model", withExtension: "momd")
    let m = NSManagedObjectModel(contentsOf: modelURL!)!
    
    
    let container = NSPersistentContainer(name: "ApplicationName", managedObjectModel: m )
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  public func saveContext () {
    print("Saving...")
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
        dump()
        
        
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  public func dump() {
    let personFetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
    personFetchRequest.fetchLimit = 2
    //personFetchRequest.relationshipKeyPathsForPrefetching = ["cars"]
    
    
    do {
      let context = persistentContainer.viewContext
      
      let fetchedEntities = try context.fetch(personFetchRequest)
      print("Dump")
      for user in fetchedEntities {
        print("# \(user.name!) ##########")
        //for session in user.sessions! {
        //  print(session)
        //}
      }
      
    } catch {
      // Do something in response to error condition
    }
    
  }
  
}

