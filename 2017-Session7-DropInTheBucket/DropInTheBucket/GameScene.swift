//
//  GameScene.swift
//  DropInTheBucket
//
//  Created by T. Andrew Binkowski on 5/6/15.
//  Copyright (c) 2015 BabyBinks. All rights reserved.
//

import SpriteKit

/// The "names" of the nodes in my scene
enum Category: String {
    case RainDropCategoryName = "RainDrop"
    case BallCategoryName = "Ball"
    case SpoonCategoryName = "Spoon"
    case HoleCategoryName = "Hole"
}

/// Each physics body identifies a category that it belongs to.  You can use
/// literals values but they need to be squares.  Check out this SO answer
/// http://stackoverflow.com/questions/24069703/how-to-define-category-bit-mask-enumeration-for-spritekit-in-swift
enum PhysicsCategory: UInt32 {
    case edge = 0           //0x1 << 0
    case ball = 1           //0x1 << 1
    case spoon = 2          //0x1 << 2
    case hole = 4           //0x1 << 3
    case rainDrop = 8       //0x1 << 4
    case gravityField = 16  //0x1 << 5
    case floor = 32         //0x1 << 6
}


class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        setupPhysics()
        setupFloor()
        setupSpoon()
      
         // Add a gesture recognizer to the scene so a double tap makes it rain
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameScene.doubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)

    }
  

    //
    // MARK: - Physics Management
    //
  
    /// Add a gray rectangle that shows us where the physics body is located
    /// to make it easier to visualize during demonstration.
    func setupPhysics() {
    
        let physicsFrame = frame.insetBy(dx: 50, dy: 50)
        let gamePlayBackground = SKShapeNode(rect: physicsFrame)
        gamePlayBackground.fillColor = UIColor.lightGray
        gamePlayBackground.zPosition = -1
        addChild(gamePlayBackground)
      
        // Bounding edge of the screen in the physics simulation
        // This is commented out so you can see how the floor only interacts with
        // the green balls, not the blue rain drops
        let borderBody = SKPhysicsBody(edgeLoopFrom: physicsFrame)
        borderBody.friction = 0
        physicsBody = borderBody

        // Pass our phyics contacts to this scene
        physicsWorld.contactDelegate = self
    }
  
    //
    // MARK: - Node Management
    //
    func setupFloor() {
        let floor = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frame.width, height: 10))
        floor.fillColor = UIColor.orange
        floor.physicsBody = SKPhysicsBody(edgeLoopFrom: floor.frame)
        floor.physicsBody!.categoryBitMask = PhysicsCategory.floor.rawValue
        floor.physicsBody!.collisionBitMask = PhysicsCategory.ball.rawValue
        addChild(floor)
    }
  
    func setupSpoon() {
        let spoon = Spoon(position:CGPoint(x: 100, y: 100))
        addChild(spoon)
    }
  
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // If the touch is >500, then add a new green ball
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("Location:\(location)")
            if location.y > 500 {
                let ball: Ball = Ball.init(position: location)
                self.addChild(ball)
            }
        }
    }
    
    // MARK: - Game Loop
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        self.enumerateChildNodes(withName: Category.RainDropCategoryName.rawValue, using: {
            node, stop in
            print(node)
            if node.position.y < 0 {
                node.removeFromParent()
            }
        })
    }
    

 
    // MARK: - Rainfall
    func doubleTap(_ sender: UITapGestureRecognizer) {
        rain()
    }
  
    //
    // MARK: - Nodes and Effects
    //
  
    /// Drop a bunch of dots
    func rain() {
        // let's create 300 bouncing cubes
        for i in 1..<20 {
            let randomX: CGFloat = CGFloat(arc4random_uniform(375))
            let randomY: CGFloat = CGFloat(600+i)
            let shape = SKShapeNode(circleOfRadius: 10)
            
            shape.name = Category.RainDropCategoryName.rawValue
            shape.fillColor = UIColor.blue
            shape.lineWidth = 10
            shape.position = CGPoint(x: randomX, y: randomY)
            print("\(i) position:\(shape.position.x) \(shape.position.y)")
            
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            shape.physicsBody!.isDynamic = true

            // Allow the balls to bounce off eachother 
            // to see how the collision bit mask works uncomment PhysicsCategory.Floor
            shape.physicsBody!.collisionBitMask = PhysicsCategory.rainDrop.rawValue //| PhysicsCategory.Floo
            shape.physicsBody!.categoryBitMask = PhysicsCategory.rainDrop.rawValue
            shape.physicsBody!.contactTestBitMask = 0 // Don't report any collisions to the delegate

            self.addChild(shape)
        }
    }
    
}

// MARK: - SKPhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        // Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // Assign the two physics bodies so that the one with the lower category
        // is always stored in firstBody.  Why?  This could be useful in your
        // logic.
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //print("Contact between \(String(describing: firstBody.node?.name)) and \(String(describing: secondBody.node?.name))")
        
        // React to the contact between ball and the black hole (square).
        if firstBody.categoryBitMask == PhysicsCategory.ball.rawValue &&
           secondBody.categoryBitMask == PhysicsCategory.hole.rawValue {
          
            // Replace the log statement with display of Game Over Scene
            print("Hit bottom. First contact has been made.")
            let ball: Ball = (firstBody.node as? Ball)!
            ball.removeWithActions()
        }
    }
    

}

