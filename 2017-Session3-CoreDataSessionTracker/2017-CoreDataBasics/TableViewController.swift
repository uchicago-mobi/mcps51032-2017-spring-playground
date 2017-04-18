//
//  TableViewController.swift
//  2017-CoreDataBasics
//
//  Created by T. Andrew Binkowski on 4/17/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

//
//  SeardchTableViewController.swift
//  2017-CoreDataBasics
//
//  Created by T. Andrew Binkowski on 4/17/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  ///
  var context: NSManagedObjectContext? {
    return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
  }
  
  /// Compute the fetched results controller in a block; we will only be using
  /// one controller for this view controller
  lazy var fetchedResultsController: NSFetchedResultsController<User> = {
    
    let fetchRequest = NSFetchRequest<User>(entityName: "User")
    fetchRequest.fetchBatchSize = 10
    let dateDescriptor = NSSortDescriptor(key: "name", ascending: false)
    fetchRequest.sortDescriptors = [dateDescriptor]
    
    let _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: self.context!,
                                                               sectionNameKeyPath: "timestamp",
                                                               cacheName: nil)
    _fetchedResultsController.delegate = self
    return _fetchedResultsController
    
  }()
  
  
  //
  // MARK: - Lifecycle
  //
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    do {
      try self.fetchedResultsController.performFetch()
    } catch {
      let nserror = error as NSError
      print("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    
    tableView.reloadData()
    
  }
  
  //
  // MARK: - Table view data source
  //
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    if let sections = fetchedResultsController.sections {
      return sections.count
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = fetchedResultsController.sections {
      let currentSection = sections[section]
      return currentSection.numberOfObjects
    }
    return 0
    
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if let sections = fetchedResultsController.sections {
      let currentSection = sections[section]
      return currentSection.name
    }
    return nil
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    // Configure the cell...
    let user = fetchedResultsController.object(at: indexPath)
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.timestamp?.description
    return cell
  }
  
}
