//
//  GameViewController.swift
//  DropInTheBucket
//
//  Created by T. Andrew Binkowski on 5/6/15.
//  Copyright (c) 2015 BabyBinks. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let scene = GameScene(fileNamed: "GameScene") {
      // Configure the view.
      let skView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      skView.showsPhysics = true
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      
      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .aspectFit
      
      skView.presentScene(scene)
    }
  }
  
  override var shouldAutorotate : Bool {
    return true
  }
  
  override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return UIInterfaceOrientationMask.allButUpsideDown
    } else {
      return UIInterfaceOrientationMask.all
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override var prefersStatusBarHidden : Bool {
    return true
  }
}
