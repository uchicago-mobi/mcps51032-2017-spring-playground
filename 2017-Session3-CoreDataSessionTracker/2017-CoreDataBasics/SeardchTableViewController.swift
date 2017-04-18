//
//  SeardchTableViewController.swift
//  2017-CoreDataBasics
//
//  Created by T. Andrew Binkowski on 4/17/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CoreData


class SearchTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

  /// Get a reference to the persistent container in ther app delegate
  var context: NSManagedObjectContext? {
    return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
  }
  
  
  /// Compute the fetched results controller in a block; we will only be using
  /// one controller for this view controller
  lazy var fetchedResultsController: NSFetchedResultsController<User> = {
    let fetchRequest = NSFetchRequest<User>(entityName: "User")
    fetchRequest.fetchBatchSize = 10
    fetchRequest.predicate = self.currentPredicate
    let dateDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
    fetchRequest.sortDescriptors = [dateDescriptor]
    
    let _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: self.context!,
                                                               sectionNameKeyPath: "name",
                                                               cacheName: nil)
    _fetchedResultsController.delegate = self
    return _fetchedResultsController
    
  }()
  
  /// Predicate variables; set default value to everything
  var currentPredicate: NSPredicate = NSPredicate(format: "TRUEPREDICATE")
  
  /// Search bar
  let searchController = UISearchController(searchResultsController: nil)


  // MARK: - Lifecycle
  override func viewDidLoad() {
    
    super.viewDidLoad()
    // Load up the search controller.  There are many options on how it displays
    // that do not effect the behavior.
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.searchBarStyle = .prominent
    //searchController.hidesNavigationBarDuringPresentation = false
    
    // Show a scope bar for additional filtering parameters
    searchController.searchBar.scopeButtonTitles = ["Like Beer", "Likes Wine"]
    searchController.searchBar.delegate = self
    
    // Place the search bar in the header
    tableView.tableHeaderView = searchController.searchBar
    //navigationItem.titleView = searchController.searchBar
    definesPresentationContext = true

    fetch()
  }
  
  
  // MARK: - Table view data source
  
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
      return String(currentSection.name.characters.prefix(1))
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
  
  
  //
  // MARK: - Data Fetch and Format
  //
  
  
  /// Perform a fetch against the Core Data store.  This will be called many
  /// different times: initialization, search, cleared search.
  func fetch() {
    print("🐶 Fetch with predicate: \(self.fetchedResultsController.fetchRequest.predicate!)")
    do {
      fetchedResultsController.fetchRequest.predicate = currentPredicate
      try self.fetchedResultsController.performFetch()
    } catch {
      let nserror = error as NSError
      print("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
  
  /// Filter the data store by the text query and scope in the search bar
  /// - Note: Scope is not actually used here.
  func filterResultsForSearchText(_ text: String, scope: String = "All") {
    print("\t🎹SearchBar: \(text) Scope: \(scope)")
    
    // Match everything unless there is text in the search bar
    if text.characters.count == 0 {
      self.currentPredicate = NSPredicate(format: "TRUEPREDICATE")
    } else {
      self.currentPredicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
    }
    fetch()
    tableView.reloadData()
  }
  
}


///
/// UISearchResultsDelegate
///


extension SearchTableViewController: UISearchResultsUpdating {
  
  /// Update the search results based on the text in the search bar.  We could
  /// also use the scope bar, but we are not in this example
  /// - paremeter searchController: The search controller sending the message
  ///
  func updateSearchResults(for searchController: UISearchController) {
    // Use this is you want to use the scope to filter on as well
    //let searchBar = searchController.searchBar
    //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    let scope = "Dummy Text to hide scope for now"
    
    filterResultsForSearchText(searchController.searchBar.text!,scope: scope)
  }
}

///
/// UISearchBarDelegate
///
extension SearchTableViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterResultsForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}
