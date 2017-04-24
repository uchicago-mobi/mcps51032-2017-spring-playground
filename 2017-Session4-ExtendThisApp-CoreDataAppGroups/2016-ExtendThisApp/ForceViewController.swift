//
//  ForceViewController.swift
//  2017-ExtendThisApp
//
//  Created by T. Andrew Binkowski on 4/24/17.
//  Copyright © 2017 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

class ForceViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


class ForceView: UIView {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      print(touch.force)
      print(touch.maximumPossibleForce)
      
    }
    
  }
}
