//
//  ViewController.swift
//  emojiTV
//
//  Created by T. Andrew Binkowski on 5/21/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
  private var focusGuide: UIFocusGuide!
  
  let data = ["😀","😁","😂","😃","😄","😅","😆","😇","😈","👿","😉","😊","☺️","😋","😌","😍","😎","😏","😐","😑","😒","😓","😔","😕","😖","😗","😘","😙","😚","😛","😜","😝","😞","😟","😠","😡","😢","😣","😤","😥","😦","😧","😨","😩","😪","😫","😬","😭","😮","😯","😰","😱","😲","😳","😴","😵","😶","😷"]

  @IBOutlet weak var bigLabel:UILabel!
  
  @IBAction func tapButton(_ sender: UIButton) {
    print("Tap")
  }
  
  
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      self.tableView.delegate = self
      self.tableView.dataSource = self
    }
  }
  
  override var preferredFocusEnvironments : [UIFocusEnvironment] {
    return [tableView]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("HI")
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    self.tableView.remembersLastFocusedIndexPath = true
    
    /*
     Create a focus guide to fill the gap below button 2 and to the right
     of button 3.
     */
    focusGuide = UIFocusGuide()
    view.addLayoutGuide(focusGuide)
    
    // Anchor the top left of the focus guide.
    focusGuide.leftAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
  }
  
  
  // MARK: UIFocusEnvironment
  
  override func didUpdateFocus(in context: UIFocusUpdateContext,
                               with coordinator: UIFocusAnimationCoordinator) {
    super.didUpdateFocus(in: context, with: coordinator)
    
    /*
     Update the focus guide's `preferredFocusedView` depending on which
     button has the focus.
     */
    guard let nextFocusedView = context.nextFocusedView else { return }
    
    switch nextFocusedView {
    case tableView:
      focusGuide.preferredFocusEnvironments = [button]
      
    case button:
      focusGuide.preferredFocusEnvironments = [tableView]
      
    default:
      focusGuide.preferredFocusEnvironments = []
    }
  }
  
  
}


extension ViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.data.count
  }
}


extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = data[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("tap: \(indexPath.row)")
    self.bigLabel?.text = data[indexPath.row]
  }
  
  
  /// Update when we change focus
  func tableView(_ tableView: UITableView,
                 didUpdateFocusIn context: UITableViewFocusUpdateContext,
                 with coordinator: UIFocusAnimationCoordinator) {
    // this gives you the indexpath of the focused cell
    if let indexPath = context.nextFocusedIndexPath {
      self.bigLabel?.text = data[indexPath.row]
    }
  }
  
  
  
  
}
