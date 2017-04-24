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
    sharedItems = LocalDefaultsManager.sharedInstance.currentList()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TableViewController.refreshTable), name: UIApplicationDidBecomeActiveNotification, object: nil)
    
    // Useful for debugging
    // LocalDefaultsManager.sharedInstance.reset()
  }
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func refreshTable() {
    print("Refreshing Table")
    sharedItems = LocalDefaultsManager.sharedInstance.currentList()
    self.tableView.reloadData()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }
  
  // -------------------------------------------------------------------------
  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sharedItems.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    let sharedItemDictionary: NSDictionary = sharedItems[indexPath.row] as! NSDictionary
    
    cell.textLabel!.text = sharedItemDictionary["contentText"] as? String
    cell.detailTextLabel!.text = (sharedItemDictionary["date"] as? NSDate)!.description
    
    // The images are stored here as NSData inside of NSUserDefaults, we
    // need to convert to an UIImage before we add it to the table
    if let imageData = sharedItemDictionary["imageData"] as? NSData {
      cell.imageView!.image = UIImage(data: imageData)
    }
    
    return cell
  }
  
}
