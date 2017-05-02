//
//  InterfaceController.swift
//  WatchOS2LastEmojiSwift WatchKit Extension
//
//  Created by Thai, Kristina on 6/21/15.
//  Copyright © 2015 Kristina Thai. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController {
  
  fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
  
  //
  // MARK: - IBOutlet
  //
  override init() {
    super.init()
    session?.delegate = self
    session?.activate()
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
  }
  
  override func willActivate() {
    super.willActivate()
  }
  
  override func didDeactivate() {
    super.didDeactivate()
  }
  
  //
  // MARK: - IBOutlet
  //
  @IBOutlet var contextLabel: WKInterfaceLabel!
  
  
  //
  // MARK: - IBActions
  //
  
  
  @IBAction func catPressed() {
    sendEmoji("cat")
  }
  
  @IBAction func dogPressed() {
    sendEmoji("dog")
  }
  
  @IBAction func pandaPressed() {
    sendEmoji("panda")
  }
  
  @IBAction func bunnyPressed() {
    sendEmoji("bunny")
  }
  
  @IBAction func cowPressed() {
    sendEmoji("cow")
  }
  
  @IBAction func hamsterPressed() {
    sendEmoji("hamster")
  }
  
  
  // Sendout the emoji using application context    
  // and messages
  func sendEmoji(_ emoji: String){
    let applicationDict = ["emoji" : emoji]
    do {
      try session?.updateApplicationContext(applicationDict)
    } catch {
      print("error")
    }
    
    // Send both ways
    let applicationDictMessage = ["text":"Hi from interactive Watch message."]
    session?.sendMessage(applicationDictMessage, replyHandler: { (reply) in
      print("Reply: \(reply)")
    }) { (error) in
      print("Error: \(error)")
    }
  }
}

///
///
extension InterfaceController: WCSessionDelegate {
  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(watchOS 2.2, *)
  public func session(_ session: WCSession,
                      activationDidCompleteWith activationState: WCSessionActivationState,
                      error: Error?) {
    print("WCSession activated")
  }
  
  //
  func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
    let emoji = applicationContext["emoji"] as? String
    print("HI")
    
    //Use this to update the UI instantaneously (otherwise, takes a little while)
    DispatchQueue.main.async {
      if let emoji = emoji {
        self.contextLabel.setText(emoji)
        
      }
    }
  }
}
