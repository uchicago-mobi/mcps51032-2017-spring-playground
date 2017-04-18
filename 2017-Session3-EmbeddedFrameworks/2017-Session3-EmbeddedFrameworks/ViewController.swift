//
//  ViewController.swift
//  2017-Session3-EmbeddedFrameworks
//
//  Created by T. Andrew Binkowski on 4/17/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import GreetingKit
import ClassKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let g = Greetings()
    g.happy()
    
    let c = ClassGreeting()
    c.crazy()

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

