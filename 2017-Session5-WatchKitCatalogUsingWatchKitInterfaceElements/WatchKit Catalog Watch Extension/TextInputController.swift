/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller demonstrates using the Text Input Controller.
 */

import WatchKit
import WatchConnectivity

class TextInputController: WKInterfaceController {
    
    @IBAction func replyWithTextInputController() {

        let resultHandler = {(results: [Any]?) in
            print("Text Input Results: \(results)")
            if results?.first != nil {
                // Sends a non-nil result to the parent iOS application.
                WCSession.default().sendMessage(["TextInput" : (results?.first)!], replyHandler: { (replyMessage) in
                        print("Reply Info: \(replyMessage)")
                    }, errorHandler: { (error) in
                        print("Error: \(error.localizedDescription)")
                })
            }
        }
        
        // Using the WKTextInputMode enum, you can specify which aspects of the Text Input Controller are shown when presented.
        presentTextInputController(withSuggestions: ["Yes", "No", "Maybe"], allowedInputMode: .allowEmoji, completion: resultHandler)
    }
    
}
