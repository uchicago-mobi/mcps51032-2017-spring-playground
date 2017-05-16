//
//  File.swift
//  BounceAroundTheRoom
//
//  Created by T. Andrew Binkowski on 5/5/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKShapeNode {
    
    let number: Int = Int(arc4random_uniform(10) + 1)
    var radius: CGFloat!
    var circumference: CGFloat!
    
    override init() {
        super.init()
        circumference = CGFloat(number * 10)
        radius = CGFloat(circumference / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(position: CGPoint) {
        self.init()
        
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: circumference, height: circumference), transform: nil)
        self.position = position
        self.fillColor = UIColor.blue
        self.strokeColor = UIColor.blue
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
      
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.friction = 0
        self.physicsBody!.restitution = 1
        self.physicsBody!.linearDamping = 0
        self.physicsBody!.angularDamping = 0
    

        let numberLabel = SKLabelNode(fontNamed: "Avenir-Next")
        numberLabel.fontSize = CGFloat(circumference - 1)
        numberLabel.verticalAlignmentMode = .center
        numberLabel.horizontalAlignmentMode = .center
        numberLabel.text = "\(number)"

        
        self.addChild(numberLabel)
        
        let shrink = SKAction.scale(to: 0.0, duration: 0.0)
        let grow = SKAction.scale(to: 1.0, duration: 0.5)
        let tink = SKAction.playSoundFileNamed("Tink.caf", waitForCompletion: false)
        self.run(SKAction.sequence([tink,shrink,grow]))

    }
}
