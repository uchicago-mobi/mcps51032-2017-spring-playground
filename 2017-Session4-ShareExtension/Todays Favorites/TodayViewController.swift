//
//  TodayViewController.swift
//  Todays Favorites
//
//  Created by T. Andrew Binkowski on 4/22/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import NotificationCenter
import ExtensionKit

class TodayViewController: UIViewController {
  
  /// Array to hold all the shared items loaded from NSUserDefaults
  var sharedItems: NSMutableArray = []
  
  @IBOutlet weak var tableView: UITableView!
  
  
  //
  // MARK: - Lifecycle
  //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Size the widget for initial view
    self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
    
    // Retrieve the list of apps that is stored in AppGroups UserDefaults
    sharedItems = LocalDefaultsManager.sharedInstance.currentList()
  }
  
  //
  // MARK: - Table view data source
  //
  func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sharedItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
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
  
  
  //
  // MARK: - Table view data delegate methods
  //
  
  
  func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let row = indexPath.row
    
    // We are using a custom URL to pass the index of the tapped cell
    // You can use this to customize the launch of the container application
    let launchString = "mobiuchicagoshare://indexPathRow=\(row)"
    self.extensionContext?.open(URL(string: launchString)!, completionHandler:nil)
  }
}




//
// MARK: - NCWidgetProviding Methods
//


extension TodayViewController : NCWidgetProviding {
  
  func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize){
    if (activeDisplayMode == NCWidgetDisplayMode.compact) {
      self.preferredContentSize = maxSize;
    } else {
      self.preferredContentSize = CGSize(width: 0, height: 400);
    }
  }
  
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    // Perform any setup necessary in order to update the view.
    // If an error is encountered, use NCUpdateResult.Failed
    // If there's no update required, use NCUpdateResult.NoData
    // If there's an update, use NCUpdateResult.NewData
    
    // Refresh table
    self.tableView.reloadData()
    completionHandler(NCUpdateResult.newData)
  }
  
}
