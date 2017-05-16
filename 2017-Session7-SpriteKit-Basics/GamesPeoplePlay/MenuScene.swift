//
//  MeneScene.swift
//  GamesPeoplePlay
//
//  Created by T. Andrew Binkowski on 5/15/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let view = self.view {
      // Load the SKScene from 'GameScene.sks'
      
      if let scene = SKScene(fileNamed: "GameScene") {
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene, transition: .crossFade(withDuration: 1.0))
      }
    }
  }
}
