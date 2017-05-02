//
//  ViewController.swift
//  WatchOS2LastEmojiSwift
//
//  Created by Thai, Kristina on 6/21/15.
//  Copyright © 2015 Kristina Thai. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
  @IBOutlet weak var emojiLabel: UILabel!
  
  //
  //
  @IBAction func tapSend(_ sender: UIButton) {
    print("Tap (application context")
    do {
      let applicationDict = ["emoji":"👍"]
      try WCSession.default().updateApplicationContext(applicationDict)
    } catch {
      // Handle errors here
      print(error)
    }
    
  }
  
  fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
  
  
  override func viewDidLoad() {
    session?.delegate = self
    session?.activate()
  }
}

extension ViewController: WCSessionDelegate {
  
  @available(iOS 9.3, *)
  public func sessionDidDeactivate(_ session: WCSession) {
    //Dummy Implementation
  }
  

  @available(iOS 9.3, *)
  public func sessionDidBecomeInactive(_ session: WCSession) {
    //Dummy Implementation
  }
  
  @available(iOS 9.3, *)
  public func session(_ session: WCSession,
                      activationDidCompleteWith activationState: WCSessionActivationState,
                      error: Error?) {
    print("Actication: \(activationState)")
  }
  
  func session(_ session: WCSession,
               didReceiveApplicationContext applicationContext: [String : Any]) {
    let emoji = applicationContext["emoji"] as? String
    
    //Use this to update the UI instantaneously (otherwise, takes a little while)
    DispatchQueue.main.async {
      if let emoji = emoji {
        self.emojiLabel.text = "Last emoji: \(emoji)"
      }
    }
  }
  
  func session(_ session: WCSession, didReceiveMessageData messageData: Data) {}
  func session(_ session: WCSession,
               didReceiveMessage message: [String : Any],
               replyHandler: @escaping ([String : Any]) -> Void) {
    print("Message Data:\(message)")
  }
}

