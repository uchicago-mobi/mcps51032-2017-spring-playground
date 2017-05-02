/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This controller displays images, static and animated. It demonstrates using the image cache to send images from the WatchKit app extension bundle to be stored and used in the WatchKit app bundle. It also demonstrates how to use screenBounds to use the most appropriate sized image for the device at runtime. Finally, this controller demonstrates loading images from the WatchKit Extension bundle and from the WatchKit app bundle.
 */

import WatchKit

class ImageDetailController: WKInterfaceController {
    @IBOutlet var staticImage :WKInterfaceImage!
    @IBOutlet var animatedImage :WKInterfaceImage!
    @IBOutlet var playButton :WKInterfaceButton!
    @IBOutlet var stopButton :WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let imageData = UIImagePNGRepresentation(UIImage(named: "Walkway")!)
        staticImage.setImageData(imageData)
    }
    
    @IBAction func playAnimation() {
        // Uses images in WatchKit app bundle.
        animatedImage.setImage(UIImage(named: "Bus"))
        animatedImage.startAnimating()
    
        // Animate with a specific range, duration, and repeat count.
        //animatedImage.startAnimatingWithImages(in: NSMakeRange(0, 4), duration: 2.0, repeatCount: 3)
    }
    
    @IBAction func stopAnimation() {
        animatedImage.stopAnimating()
    }
}
