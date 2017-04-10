//:
//: MPCS51032 - Session 2 - Attributed Strings
//: ==========================================
//:

import UIKit

/*:
 ----
 Using Attributed Strings with Labels
 ------------------------------------
 Create a UILabel, change the color and round the corners of the label.
 Font and color properties apply to the entire label.
 */

let helloLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 100))
helloLabel.backgroundColor = UIColor.yellow
helloLabel.layer.masksToBounds = true
helloLabel.layer.cornerRadius = 10.0
helloLabel.textAlignment = NSTextAlignment.center
helloLabel.text = "Hello Label!"


//: Let the label use an attributed string instead
var attributedString = NSMutableAttributedString()
attributedString = NSMutableAttributedString(string: "Fancy Hello World!",
                                             attributes: [
                                              NSFontAttributeName:UIFont(name: "Georgia", size: 50.0)!
  ])
helloLabel.attributedText = attributedString


//: [Next](@next)
