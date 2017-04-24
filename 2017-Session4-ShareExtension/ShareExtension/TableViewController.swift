//
//  TableViewController.swift
//  ShareExtension
//
//  Created by T. Andrew Binkowski on 4/21/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import ExtensionKit

class TableViewController: UITableViewController {
  
  /// The array that will hold our favorites list from user defaults
  var sharedItems: NSMutableArray = []
  
  //
  // MARK: - Lifecycle
  //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //sharedItems = LocalDefaultsManager.sharedInstance.currentList()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(TableViewController.refreshTable),
                                           name: NSNotification.Name.UIApplicationDidBecomeActive,
                                           object: nil)
    
    // Useful for debugging
    // LocalDefaultsManager.sharedInstance.reset()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func refreshTable() {
    print("Refreshing Table")
    sharedItems = LocalDefaultsManager.sharedInstance.currentList()
    self.tableView.reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }
  
  // -------------------------------------------------------------------------
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sharedItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let sharedItemDictionary: NSDictionary = sharedItems[indexPath.row] as! NSDictionary
    
    cell.textLabel!.text = sharedItemDictionary["contentText"] as? String
    cell.detailTextLabel!.text = (sharedItemDictionary["date"] as? Date)!.description
    
    // The images are stored here as NSData inside of NSUserDefaults, we
    // need to convert to an UIImage before we add it to the table
    if let imageData = sharedItemDictionary["imageData"] as? Data {
      cell.imageView!.image = UIImage(data: imageData)
    }
    
    return cell
  }
  
}
