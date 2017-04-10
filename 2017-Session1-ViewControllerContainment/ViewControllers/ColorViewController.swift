//
//  ColorViewController.swift
//  ViewControllers
//
//  Created by T. Andrew Binkowski on 3/27/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

///
/// Protocol that allows the remove child view controller cycle to be called
/// by the parent view controller
///
protocol ColorViewControllerDelegate: class {
  func removeFromContainerViewController(_ sender: ColorViewController)
}


///
/// View controller that can either dismiss itself or tell a parent view 
/// controller to remove it
///
class ColorViewController: UIViewController {
  
  var closeButton: UIButton?
  
  /// Keep a reference to the parent view controller
  weak var delegate: ColorViewControllerDelegate?

  //
  // MARK: - IBActions
  //
  
  @IBAction func tapCloseButton(_ sender: UIButton) {
    
    if parent != nil {
    
        delegate?.removeFromContainerViewController(self)
   
     } else {
      
      
      presentingViewController?.dismiss(animated: true, completion: nil)
      
    }
    
  }
  
  //
  // MARK: - Life
  //
  
  override func viewDidLoad() {
    super.viewDidLoad()
        
    // Do any additional setup after loading the view.
  }
  
  
  
}
