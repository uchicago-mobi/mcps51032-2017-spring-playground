/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The master view controller.
*/

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: Properties
    
    let sampleData = [
        "Item 1",
        "Item 2",
        "Item 3"
    ]
    
    /// An alert controller used to notify the user if 3D touch is not available.
    var alertController: UIAlertController?

    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for force touch feature, and add force touch/previewing capability.
        if traitCollection.forceTouchCapability != .available {
            // Create an alert to display to the user.
            alertController = UIAlertController(title: "3D Touch Not Available", message: "Unsupported device.", preferredStyle: .alert)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        // Clear the selection if the split view is only showing one view controller.
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Present the alert if necessary.
        if let alertController = alertController {
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
            // Clear the `alertController` to ensure it's not presented multiple times.
            self.alertController = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        /*
            Check if this is a segue from a cell and that it's presenting a
            `DetailViewController` embedded in a `UINavigationController`.
        */
        if let cell = sender as? UITableViewCell,
            let indexPath = self.tableView.indexPath(for: cell),
            let navigationController = segue.destination as? UINavigationController,
            let detailViewController = navigationController.viewControllers.first as? DetailViewController
        {
            // Pass the `title` to the `detailViewController`.
            detailViewController.sampleTitle = sampleData[(indexPath as NSIndexPath).row]

            // Hide the navigation bar if this is the peek segue.
            navigationController.isNavigationBarHidden = segue.identifier == "previewDetail"
        }
    }
    
    // MARK: Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        return sampleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = sampleData[(indexPath as NSIndexPath).row]
        
        return cell
    }
}
