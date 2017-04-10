//
//  ViewController.swift
//  ViewControllers
//
//  Created by T. Andrew Binkowski on 3/27/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

///
///
class ViewController: UIViewController {
  
  var greenViewController: ColorViewController?
  
  /// Add a child view controller
  @IBAction func tapAddRed(_ sender: UIBarButtonItem) {
    
    // Create instance of view controller and color it red (despite the name)
    let gvc = ColorViewController(nibName: "GreenViewController", bundle: nil)
    gvc.delegate = self
    gvc.view.backgroundColor = UIColor.red
    
    // 1.
    addChildViewController(gvc)
    
    // 2.
    gvc.view.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
    view.addSubview(gvc.view)
    
    // 3.
    gvc.didMove(toParentViewController: self)
    
    //
    self.greenViewController = gvc
    
    
  }
  
  /// Present a view controller that is created from a .xib
  @IBAction func tapGreenButton(_ sender: UIBarButtonItem) {
    
    // Create a view controller and present it.  If the .xib file has the same
    // name, we don't need to explicity name it.
    
    let gvc = ColorViewController(nibName: "GreenViewController", bundle: nil)
    //let gvc = ColorViewController()
    present(gvc, animated: true, completion: nil)
    
  }
  
  
  
  @IBAction func tapSwap(_ sender: UIBarButtonItem) {
    
    let gvc = ColorViewController(nibName: "GreenViewController", bundle: nil)
    gvc.delegate = self
    gvc.view.backgroundColor = UIColor.yellow
    gvc.view.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
    gvc.view.alpha = 0.0

    // The view controllers have to have the same parent
    addChildViewController(gvc)

    self.transition(from: greenViewController!, to: gvc, duration: 2.0, options: .curveEaseInOut,
                    animations: { 
                      self.greenViewController?.view.alpha = 0.0
                      gvc.view.alpha = 1.0
                      
                      
    }) { (done) in
      print("done")
    }
  }
  
  
  @IBAction func tapNibby(_ sender: UIButton) {
    // A little bit of magic here
    let vc = NibbyViewController()
    present(vc, animated: true, completion: nil)
  }
}

///
///
///
extension ViewController: ColorViewControllerDelegate {
  
  
  func removeFromContainerViewController(_ sender: ColorViewController) {
    
    // 1. Calls the child’s willMoveToParentViewController: method with a
    // parameter of nil to tell the child that it is being removed.
    sender.willMove(toParentViewController: nil)
    
    // 2. Clean up the view hierarchy
    sender.view.removeFromSuperview()
    
    // 3. Calls the child’s removeFromParentViewController method to remove it
    // from the container.
    sender.removeFromParentViewController()
    
  }
}




