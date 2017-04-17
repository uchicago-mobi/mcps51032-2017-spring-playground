import UIKit
import PlaygroundSupport

import AVFoundation
import PlaygroundSupport


class PlaygroundViewController: UIViewController, AVSpeechSynthesizerDelegate {
  
  
  let string = "One fish Two fish Red fish Blue fish. Black fish Blue fish Old fish New; fish. This one has a little star. This one has a little car. Say! What a lot of fish there are;"
  
  // Create a yellow box view
  var box = UIView(frame: CGRect(x: 100,y: 100,
                                 width: 100, height: 100))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.frame = CGRect(x: 0, y: 0,
                             width: 320, height: 480)
    self.view.backgroundColor = .darkGray
    box.backgroundColor = .yellow
    self.view.addSubview(box)
    
    
    // Create a tap gesture recoginzer
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(handleTap(_:)))
    tapGesture.numberOfTapsRequired = 1
    
    // Add tap gesture recognizer to the box
    box.addGestureRecognizer(tapGesture)
  }
  
  /// Handle the tap gesture recognizer
  func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
    print("talk")
    
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.delegate = self
    let voice = AVSpeechSynthesisVoice(language: "en_US")
    let utterance = AVSpeechUtterance(string: string)
    utterance.voice = voice
    utterance.pitchMultiplier = 1.0
    utterance.rate = 0.25
    synthesizer.speak(utterance)
    
  }
  
  //
  // Delegate
  //
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                         didStart utterance: AVSpeechUtterance) {
    print("Started")
  }
  
  
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                         willSpeakRangeOfSpeechString characterRange: NSRange,
                         utterance: AVSpeechUtterance) {
    print("📣 \(characterRange.location) - \(characterRange.length+characterRange.location)")
  }
  

}


// Create an instance of the view controller
let viewController = PlaygroundViewController()

// Allow playground to execute
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController.view
