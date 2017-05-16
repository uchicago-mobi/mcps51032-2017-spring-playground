//
//  Line.swift
//  DropInTheBucket
//
//  Created by T. Andrew Binkowski on 5/6/15.
//  Copyright (c) 2015 BabyBinks. All rights reserved.
//

import Foundation
import SpriteKit


func DegreesToRadians (_ value:Double) -> Double {
    return value * M_PI / 180.0
}

class Spoon: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "Spoon")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        self.position = position
        self.isUserInteractionEnabled = true
        self.zRotation = CGFloat(DegreesToRadians(0))

        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody!.friction = 0.8
        self.physicsBody!.isDynamic = false
        self.physicsBody!.categoryBitMask = PhysicsCategory.spoon.rawValue
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
      
        for touch in (touches ) {
            let location = touch.location(in: self.parent!)
            let touchedNode = atPoint(location)
            touchedNode.position = location
        }
    }

}
