//
//  GameScene.swift
//  BounceAroundTheRoom
//
//  Created by T. Andrew Binkowski on 5/3/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  var redBox: SKSpriteNode?

  
  override func didMove(to view: SKView) {
    super.didMove(to: view)
    
    // Ensure that the scene fits the window. Note: This does not ensure
    // that everything will look good or fit appropriately.  Switch between
    // iPhone and iPad to see what it happening
    scaleMode = .aspectFit
    //physicsWorld.contactDelegate = self
    // Create physics bounds from the edge
    let borderBody = SKPhysicsBody(edgeLoopFrom:self.frame.insetBy(dx: 100, dy: 100))
    borderBody.friction = 0
    self.physicsBody = borderBody
    
    //
    redBox = self.childNode(withName: "RedBox") as? SKSpriteNode

    // Setup initial camera position
    updateCamera()
  }
  
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    /* Called when a touch begins */
    for touch in (touches ) {
      let location = touch.location(in: self)
      let ball: Ball = Ball.init(position: location)
      self.addChild(ball)
    }
  }
  
  
  //
  // MARK: - Game Loop
  //

  /// Called before each frame is rendered
  override func update(_ currentTime: TimeInterval) {
    //print("\(redBox?.position) --> \(camera?.position)")
    updateCamera()
  }
  
  /// Update the camera position by following around the red box.  There is only
  /// a single camera assumed to be on the scene for this example.
  func updateCamera() {
    if let camera = camera {
      camera.position = CGPoint(x: redBox!.position.x, y: redBox!.position.y)
    }
  }
  
}

// MARK: - SKPhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {

  func didBegin(_ contact: SKPhysicsContact) {
    // Create local variables for two physics bodies
    let firstBody: SKPhysicsBody
    let secondBody: SKPhysicsBody
    
    // Assign the two physics bodies so that the one with the lower category is 
    // always stored in firstBody
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    } else {
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    }
    
    print("Contact: \(firstBody) \(secondBody)")
  }

}
