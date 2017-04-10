//
//  ViewController.swift
//  Session2-UIKitDynamics
//
//  Created by T. Andrew Binkowski on 4/1/16.
//  Copyright (c) 2016 Department of Computer Science, The University of Chicago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //
  // MARK: - Property Declarations
  //
  
  // Why are they implicitly unwrapped?
  // http://stackoverflow.com/questions/24006975/why-create-implicitly-unwrapped-optionals
  
  var animator: UIDynamicAnimator!
  var gravity: UIGravityBehavior!
  var collision: UICollisionBehavior!
  var itemBehavior: UIDynamicItemBehavior!
  var snap: UISnapBehavior!
  
  /// A box we will throw around
  var square: Box!
  
  /// Keep a collection of our boxes
  var boxes: [Box] = [Box]()
  
  
  
  //
  // MARK: - Lifecycle
  //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    createBoxes()
  }
  
  
  
  //
  // MARK: - UIKit Setup Methods
  //
  
  func setup() {
    
    // Create a "diving board" out blocks can bounced off of
    let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
    barrier.backgroundColor = UIColor.black
    view.addSubview(barrier)
    
    // Set the animators reference view
    animator = UIDynamicAnimator(referenceView: view)
    
    // Set up the gravity and add to the animator
    gravity = UIGravityBehavior()
    gravity.gravityDirection = CGVector(dx: 0, dy: 1)
    animator.addBehavior(gravity)
    
    // Collision behavior
    collision = UICollisionBehavior()
    collision.collisionDelegate = self
    collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
    collision.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(collision)
    
    // Create an items behavior that we will apply to our box.  We want it
    // to be bouncy.
    itemBehavior = UIDynamicItemBehavior()
    itemBehavior.elasticity = 0.9
    itemBehavior.friction = 0.1
    
    // Create a bigger box that we will "snap" around the view.  Notice how
    // this does not have the same `itemBehavior` as the other boxes on the
    // screen.  This is because we did not add them to the box.
    square = Box(number: 100)
    square.frame = CGRect(x: 300, y: 300, width: 100, height: 100)
    view.addSubview(square)
    collision.addItem(square)
  }
  
  
  //
  // MARK: - Box Methods
  //
  
  /// Create and add a bunch of boxes to the screen
  func createBoxes() {
    for idx in 1...10 {
      let box = Box(number: idx)
      view.addSubview(box)
      makeBoxDynamic(box)
      boxes.append(box)
    }
  }
  
  /// Add the behavior to a box
  /// - parameter box: A `Box` object
  func makeBoxDynamic(_ box: UIView) {
    gravity.addItem(box)
    collision.addItem(box)
    itemBehavior.addItem(box)
  }
  
  
  //
  // MARK: View Touch Handling
  //
  
  /// Override the touche handling on the view controller's main `view` to
  /// figure out where we need to snap to
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if (snap != nil) {
      animator.removeBehavior(snap)
    }
    
    let touch = touches.first! as UITouch
    snap = UISnapBehavior(item: square, snapTo: touch.location(in: view))
    animator.addBehavior(snap)
  }
}


///
/// UICollisionBehavior Delegate Methods
///

extension ViewController: UICollisionBehaviorDelegate {
  
  
  func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
    print("Item: \(item) hit point: \(p)")
    
    // Cast the colliding item as a Box
    let collidingView = item as! Box
    
    // Highlight the collision
    collidingView.backgroundColor = UIColor.yellow
    UIView.animate(withDuration: 0.3, animations: {
      collidingView.backgroundColor = collidingView.color
    }) 
    
    // This is specific to this "game".  We only want the boxes to drop when it
    // starts.  After that, we don't want gravity.  We are detecting the first
    // collision and turning off gravity.
    if collidingView.tag == 9 {
      gravity.gravityDirection = CGVector(dx: 0, dy: 0.0)
    }
  }
  
  
}

