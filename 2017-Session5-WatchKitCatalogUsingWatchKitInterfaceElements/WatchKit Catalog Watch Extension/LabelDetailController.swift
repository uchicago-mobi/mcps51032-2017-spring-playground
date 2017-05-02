/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays labels and specialized labels (Date and Timer).
 */

import WatchKit

class LabelDetailController: WKInterfaceController {
    @IBOutlet var coloredLabel: WKInterfaceLabel!
    @IBOutlet var ultralightLabel: WKInterfaceLabel!
    @IBOutlet var timer: WKInterfaceTimer!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        coloredLabel.setTextColor(UIColor.purple)
        
        let font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightUltraLight)
        let attrsDictionary = [NSFontAttributeName : font]
        let attrString = NSMutableAttributedString(string: "Ultra Light Label", attributes: attrsDictionary)
        ultralightLabel.setAttributedText(attrString)
        
        var components = DateComponents()
        components.day = 10
        components.month = 12
        components.year = 2016
        timer.setDate(Calendar.current.date(from: components)!)
        timer.start()
    }
}
