//
//  Box.swift
//  Session2-UIKitDynamics
//
//  Created by T. Andrew Binkowski on 4/1/16.
//  Copyright (c) 2016 Department of Computer Science, The University of Chicago. All rights reserved.
//

import Foundation
import UIKit

class Box : UIView {

    /// Random color box
    let color: UIColor = {
        let red = CGFloat(CGFloat(arc4random()%100000)/100000)
        let green = CGFloat(CGFloat(arc4random()%100000)/100000)
        let blue = CGFloat(CGFloat(arc4random()%100000)/100000)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 0.85)
    }()
  
    var myFrame: CGRect?
    let maxX : CGFloat = 100;
    let maxY : CGFloat = 100;
    let boxSize : CGFloat = 30.0

    /// Keep track if it bounced
    var bounced : Bool = false
  

    //
    // MARK: - Initializers
    //
  
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(number: Int) {
        self.init(frame:CGRect.zero)
        tag = number
        commonInit()
    }
    
    func commonInit() {
        //color = randomColor()
        myFrame = randomFrame()
        self.backgroundColor = color
        if let unwrappedFrame = myFrame {
            self.frame = unwrappedFrame
        }
        // Alternate ways to get frame
        // self.frame = unwrappedFrame
    }
  
  
    //
    // MARK: - Helpers
    //

    /// Generate a random frame
    /// - returns: A `CGRect`
    func randomFrame() -> CGRect {
        let guessX = CGFloat(arc4random()).truncatingRemainder(dividingBy: maxX)
        let guessY = CGFloat(arc4random()).truncatingRemainder(dividingBy: maxY);
        return CGRect(x: guessX, y: guessY, width: boxSize, height: boxSize);
    }
}
