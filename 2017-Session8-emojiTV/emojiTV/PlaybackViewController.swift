//
//  PlaybackViewController.swift
//  emojiTV
//
//  Created by T. Andrew Binkowski on 5/22/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import AVKit

class PlaybackViewController: AVPlayerViewController {
  
  let overlayView = UIView(frame:CGRect(x: 50, y: 50, width: 200, height: 200))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    overlayView.addSubview(UIImageView(image: UIImage(named: "kitten")))
    contentOverlayView?.addSubview(overlayView)
    
    //player = AVPlayer(url: NSURL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")! as URL)
    //player?.play()
    
    // Local file
    
    guard let path = Bundle.main.path(forResource: "dog", ofType:"m4v") else {
      return
    }
    player = AVPlayer(url: URL(fileURLWithPath: path))
    player?.play()
  
  }
  
}
