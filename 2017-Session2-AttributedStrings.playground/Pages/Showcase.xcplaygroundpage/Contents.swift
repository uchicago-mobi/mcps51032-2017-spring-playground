//:
//: Attributed String Showcase
//: ==========================
//:

//: [Previous](@previous)

import UIKit

/*:
 Note that attributed string attributes are cumulative.  They will persist on that string until you change/undo them.  For highlighting words for the homework assignment, you will need to reset the previously highlighted words to the default attributes.
 */

// Create an attributed string
var attributedString = NSMutableAttributedString()

// Create an attributed string with fancy text
attributedString = NSMutableAttributedString(string: "Hello World!",
                                             attributes: [NSFontAttributeName: UIFont(name: "ChalkboardSE-Regular",
                                                                                      size: 30.0)!])



// Changing the font over a specified range defined by `NSRange`. ##
attributedString.addAttribute(NSFontAttributeName,
                              value: UIFont(name: "AmericanTypewriter-Bold", size: 18.0)!,
                              range: NSRange(location:0,length:5))


// Change font in range, stroke the letter and change color ##
attributedString.addAttribute(NSFontAttributeName,
                              value: UIFont(name: "Georgia", size: 100.0)!,
                              range: NSRange(location: 0, length: 1))

// Stroke the first letter in red
attributedString.addAttribute(NSStrokeColorAttributeName,
                              value: UIColor.red,
                              range:  NSRange(location: 0, length: 4))

// Stroke Width
attributedString.addAttribute(NSStrokeWidthAttributeName,
                              value: 2,
                              range: NSRange(location: 0, length: 1))


// Change the background color
attributedString.addAttribute(NSBackgroundColorAttributeName,
                              value: UIColor.yellow,
                              range: NSRange(location: 0, length: attributedString.length))


//: [Next](@next)
