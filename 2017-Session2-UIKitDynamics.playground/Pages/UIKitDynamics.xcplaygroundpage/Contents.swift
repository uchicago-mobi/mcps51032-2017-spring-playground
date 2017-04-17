//: Playground - noun: a place where people can play


import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
containerView.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = containerView

let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
square.backgroundColor = UIColor.gray
containerView.addSubview(square)


// UILabel
let helloLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
helloLabel.backgroundColor = UIColor.yellow
helloLabel.text = "Hello Label!"

//: Let the label use an attributed string instead
var attributedString = NSMutableAttributedString()
attributedString = NSMutableAttributedString(string: "Hello World!",
                                             attributes: [
                                              NSFontAttributeName:UIFont(name: "Georgia", size: 50.0)!
  ])
helloLabel.attributedText = attributedString
containerView.addSubview(helloLabel)


// Animator
let animator = UIDynamicAnimator(referenceView: containerView)
let gravity = UIGravityBehavior(items: [square,helloLabel])
animator.addBehavior(gravity)

// A blocker view
let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
barrier.backgroundColor = UIColor.red
containerView.addSubview(barrier)

// Enable collisions between items
let collision = UICollisionBehavior(items: [square, helloLabel])
collision.translatesReferenceBoundsIntoBoundary = true
animator.addBehavior(collision)
let rightEdge = CGPoint(x: barrier.frame.origin.x + barrier.frame.size.width,
                        y: barrier.frame.origin.y)
collision.addBoundary(withIdentifier: "barrier" as NSCopying,
                      from: barrier.frame.origin,
                      to: rightEdge)


