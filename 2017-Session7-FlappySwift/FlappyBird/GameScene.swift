//
//  GameScene.swift
//  FlappyBird
//
//  Created by Bobby Kanuri on 5/9/15
//  Based upon Nate Murray's implementation from 2014
//  https://github.com/fullstackio/FlappySwift
//
//  Originally created by Nate Murray on 6/2/14.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//
//  He created this in four hours on the day Swift was announced last year to show the joys of Swift and SpriteKit :)
//  http://www.techhive.com/article/2359706/hello-flappy-developer-creates-swift-based-flappybird-clone-in-four-hours.html
//
//  Very useful Apple documentation on handling collisions
//  https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/CodeExplainedAdventure/HandlingCollisions/HandlingCollisions.html
//
// didBeginContact method from SKPhysicsContactDelegate
// https://developer.apple.com/library/prerelease/ios/documentation/SpriteKit/Reference/SKPhysicsContactDelegate_Ref/index.html#//apple_ref/occ/intfm/SKPhysicsContactDelegate/didBeginContact:
//
//  A very useful post about changes in Swift 1.2 that will break many of the SpriteKit tutorials/demo you find online
//  http://iphonedev.tv/blog/2015/2/9/swift-12-fixes-and-breaks-a-few-things-you-should-be-excited

import SpriteKit

class GameScene: SKScene {
  let verticalPipeGap = 150.0
  
  var bird:SKSpriteNode!
  var skyColor:SKColor!
  var pipeTextureUp:SKTexture!
  var pipeTextureDown:SKTexture!
  var movePipesAndRemove:SKAction!
  var moving:SKNode!
  var pipes:SKNode!
  var canRestart = Bool()
  var scoreLabelNode:SKLabelNode!
  var score = NSInteger()
  
  // Set our category bit masks
  let birdCategory: UInt32 = 1 << 0
  let worldCategory: UInt32 = 1 << 1
  let pipeCategory: UInt32 = 1 << 2
  let scoreCategory: UInt32 = 1 << 3
  
  
  //
  // MARK: - Scene Lifecycle
  //

  override func didMove(to view: SKView) {
    
    canRestart = false
    
    // setup physics
    self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -5.0 )
    self.physicsWorld.contactDelegate = self
    
    // setup background color
    skyColor = SKColor(red: 81.0/255.0, green: 192.0/255.0, blue: 201.0/255.0, alpha: 1.0)
    self.backgroundColor = skyColor
    
    moving = SKNode()
    self.addChild(moving)
    pipes = SKNode()
    moving.addChild(pipes)
    
    //
    // Setup ground and skyline and use different timer intervals to create a 
    // simple parallax animation
    //
    let groundTexture = SKTexture(imageNamed: "land")
    groundTexture.filteringMode = .nearest // shorter form for SKTextureFilteringMode.Nearest
    
    let moveGroundSprite = SKAction.moveBy(x: -groundTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.02 * groundTexture.size().width * 2.0))
    let resetGroundSprite = SKAction.moveBy(x: groundTexture.size().width * 2.0, y: 0, duration: 0.0)
    let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
    
    
    for i:CGFloat in 0 ..< 2.0 + self.frame.size.width / ( groundTexture.size().width * 2.0 ) += 1 {
      let sprite = SKSpriteNode(texture: groundTexture)
      sprite.setScale(2.0)
      sprite.position = CGPoint(x: i * sprite.size.width, y: sprite.size.height / 2.0)
      sprite.run(moveGroundSpritesForever)
      moving.addChild(sprite)
    }
    
    //
    // Skyline
    //
    let skyTexture = SKTexture(imageNamed: "sky")
    skyTexture.filteringMode = .nearest
    
    let moveSkySprite = SKAction.moveBy(x: -skyTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.1 * skyTexture.size().width * 2.0))
    let resetSkySprite = SKAction.moveBy(x: skyTexture.size().width * 2.0, y: 0, duration: 0.0)
    let moveSkySpritesForever = SKAction.repeatForever(SKAction.sequence([moveSkySprite,resetSkySprite]))
    
    for i:CGFloat in 0 ..< 2.0 + self.frame.size.width / ( skyTexture.size().width * 2.0 ) += 1 {
      let sprite = SKSpriteNode(texture: skyTexture)
      sprite.setScale(2.0)
      sprite.zPosition = -20
      sprite.position = CGPoint(x: i * sprite.size.width, y: sprite.size.height / 2.0 + groundTexture.size().height * 2.0)
      sprite.run(moveSkySpritesForever)
      moving.addChild(sprite)
    }
    
    //
    // create the pipes textures
    //
    pipeTextureUp = SKTexture(imageNamed: "PipeUp")
    pipeTextureUp.filteringMode = .nearest
    pipeTextureDown = SKTexture(imageNamed: "PipeDown")
    pipeTextureDown.filteringMode = .nearest
    
    // create the pipes movement actions
    let distanceToMove = CGFloat(self.frame.size.width + 2.0 * pipeTextureUp.size().width)
    let movePipes = SKAction.moveBy(x: -distanceToMove, y:0.0, duration:TimeInterval(0.01 * distanceToMove))
    let removePipes = SKAction.removeFromParent()
    movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
    
    // spawn the pipes
    let spawn = SKAction.run({() in self.spawnPipes()})
    let delay = SKAction.wait(forDuration: TimeInterval(2.0))
    let spawnThenDelay = SKAction.sequence([spawn, delay])
    let spawnThenDelayForever = SKAction.repeatForever(spawnThenDelay)
    self.run(spawnThenDelayForever)
    
    // setup our bird
    let birdTexture1 = SKTexture(imageNamed: "bird-01")
    birdTexture1.filteringMode = .nearest
    let birdTexture2 = SKTexture(imageNamed: "bird-02")
    birdTexture2.filteringMode = .nearest
    
    //
    // Flap the wings using a texture animation
    //
    let anim = SKAction.animate(with: [birdTexture1, birdTexture2], timePerFrame: 0.2)
    let flap = SKAction.repeatForever(anim)
    
    bird = SKSpriteNode(texture: birdTexture1)
    bird.setScale(2.0)
    bird.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
    bird.run(flap)
    
    // configure physics body for our flappybird
    bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2.0)
    bird.physicsBody?.isDynamic = true
    bird.physicsBody?.allowsRotation = false
    
    // check if our flappybird collides with a pipe or the world (aka ground) and exclude collision with the score
    bird.physicsBody?.categoryBitMask = birdCategory
    bird.physicsBody?.collisionBitMask = worldCategory | pipeCategory
    bird.physicsBody?.contactTestBitMask = worldCategory | pipeCategory
    
    self.addChild(bird)
    
    // create the ground
    let ground = SKNode()
    ground.position = CGPoint(x: 0, y: groundTexture.size().height)
    ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: groundTexture.size().height * 2.0))
    ground.physicsBody?.isDynamic = false
    ground.physicsBody?.categoryBitMask = worldCategory
    self.addChild(ground)
    
    // initialize label and create a label which holds the score
    score = 0
    scoreLabelNode = SKLabelNode(fontNamed:"MarkerFelt-Wide")
    scoreLabelNode.position = CGPoint( x: self.frame.midX, y: 3 * self.frame.size.height / 4 )
    scoreLabelNode.zPosition = 100
    scoreLabelNode.text = String(score)
    self.addChild(scoreLabelNode)
    
  }
  
  
  //
  // MARK: - Gameplay
  //
  
  /// create pipes of random size with good old arc4random with a fixed gap and
  /// set physics body for pipes and gap gap in between the pipes becomes the
  /// scoreCategory
  func spawnPipes() {
    let pipePair = SKNode()
    pipePair.position = CGPoint( x: self.frame.size.width + pipeTextureUp.size().width * 2, y: 0 )
    pipePair.zPosition = -10
    
    let height = UInt32( UInt(self.frame.size.height / 4) )
    let y = arc4random() % height + height
    
    let pipeDown = SKSpriteNode(texture: pipeTextureDown)
    pipeDown.setScale(2.0)
    pipeDown.position = CGPoint(x: 0.0, y: CGFloat(Double(y)) + pipeDown.size.height + CGFloat(verticalPipeGap))
    
    
    pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size)
    pipeDown.physicsBody?.isDynamic = false
    pipeDown.physicsBody?.categoryBitMask = pipeCategory
    pipeDown.physicsBody?.contactTestBitMask = birdCategory
    pipePair.addChild(pipeDown)
    
    let pipeUp = SKSpriteNode(texture: pipeTextureUp)
    pipeUp.setScale(2.0)
    pipeUp.position = CGPoint(x: 0.0, y: CGFloat(Double(y)))
    
    pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
    pipeUp.physicsBody?.isDynamic = false
    pipeUp.physicsBody?.categoryBitMask = pipeCategory
    pipeUp.physicsBody?.contactTestBitMask = birdCategory
    pipePair.addChild(pipeUp)
    
    let contactNode = SKNode()
    contactNode.position = CGPoint( x: pipeDown.size.width + bird.size.width / 2, y: self.frame.midY )
    contactNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: pipeUp.size.width, height: self.frame.size.height ))
    contactNode.physicsBody?.isDynamic = false
    contactNode.physicsBody?.categoryBitMask = scoreCategory
    contactNode.physicsBody?.contactTestBitMask = birdCategory
    pipePair.addChild(contactNode)
    
    pipePair.run(movePipesAndRemove)
    pipes.addChild(pipePair)
    
  }
  
 
  /// Resets the game upon failure, which is often
  func resetScene (){
    // Move bird to original position and reset velocity
    bird.position = CGPoint(x: self.frame.size.width / 2.5, y: self.frame.midY)
    bird.physicsBody?.velocity = CGVector( dx: 0, dy: 0 )
    bird.physicsBody?.collisionBitMask = worldCategory | pipeCategory
    bird.speed = 1.0
    bird.zRotation = 0.0
    
    // Remove all existing pipes
    pipes.removeAllChildren()
    
    // Reset _canRestart
    canRestart = false
    
    // Reset score
    score = 0
    scoreLabelNode.text = String(score)
    
    // Restart animation
    moving.speed = 1
  }
  
  /// Tap - apply an impulse on the bird
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    /* Called when a touch begins */
    if moving.speed > 0  {
      for touch: AnyObject in touches {
        _ = touch.location(in: self)
        
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
        
      }
    } else if canRestart {
      self.resetScene()
    }
  }
  
  //
  // MARK: - Utilities
  //
  
  /// Ensure that the values do not exceed some specified range so that the
  /// behavior is controlled in the gameplay.
  /// BRK: Some random bird physics code cruft Nate included in his original version
  /// BRK: which I've left in place.
  func clamp(_ min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
    if( value > max ) {
      return max
    } else if( value < min ) {
      return min
    } else {
      return value
    }
  }
  
  
  //
  // MARK: - Game Loop
  //
  
  /// Called before each frame is rendered
  override func update(_ currentTime: TimeInterval) {
    // Keep the bird facing forward
    bird.zRotation = self.clamp( -1, max: 0.5, value: bird.physicsBody!.velocity.dy * ( bird.physicsBody!.velocity.dy < 0 ? 0.003 : 0.001 ) )
  }
}

extension GameScene: SKPhysicsContactDelegate {

  func didBegin(_ contact: SKPhysicsContact) {
    
    if moving.speed > 0 {
      
      // check if our flappybird made it through a gap and increase score
      if ( contact.bodyA.categoryBitMask & scoreCategory ) == scoreCategory || ( contact.bodyB.categoryBitMask & scoreCategory ) == scoreCategory {
        // Bird has contact with score entity
        score = score + 1
        scoreLabelNode.text = String(score)
        
        // Briefly scale up the score counter to provide snazzy visual feedback
        scoreLabelNode.run(SKAction.sequence([SKAction.scale(to: 1.5, duration:TimeInterval(0.1)), SKAction.scale(to: 1.0, duration:TimeInterval(0.1))]))
      } else {
        
        // whoops, our flappybird hit something else, uh oh
        moving.speed = 0
        
        bird.physicsBody?.collisionBitMask = worldCategory
        bird.run(  SKAction.rotate(byAngle: CGFloat(M_PI) * CGFloat(bird.position.y) * 0.01, duration:1), completion:{self.bird.speed = 0 })
        
        // Flash background if contact is detected
        self.removeAction(forKey: "flash")
        self.run(SKAction.sequence([SKAction.repeat(SKAction.sequence([SKAction.run({
          self.backgroundColor = SKColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        }),SKAction.wait(forDuration: TimeInterval(0.05)), SKAction.run({
          self.backgroundColor = self.skyColor
        }), SKAction.wait(forDuration: TimeInterval(0.05))]), count:4), SKAction.run({
          self.canRestart = true
        })]), withKey: "flash")
      }
    }
  }
}
