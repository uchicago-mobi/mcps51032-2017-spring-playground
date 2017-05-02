/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 'MovieDetailController' implements an interface controller diplaying a WKInterfaceMovie with a poster frame and a URL.
 */

import WatchKit

class MovieDetailController: WKInterfaceController {
    @IBOutlet var movie :WKInterfaceMovie!
    @IBOutlet var inlineMovie :WKInterfaceInlineMovie!
    @IBOutlet var tapGestureRecognizer :WKTapGestureRecognizer!
    var playingInlineMovie :Bool = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Obtain a URL pointing to the movie to play.
        let movieURL = Bundle.main.url(forResource: "Ski1", withExtension: "m4v")
        
        // Setup the `movie` interface object with the URL to play.
        movie.setMovieURL(movieURL!)
        
        // Provide a poster image to be displayed in the movie interface object prior to playback.
        movie.setPosterImage(WKImage(imageName: "Ski1"))
        
        // Setup the `inlineMovie` interface object with the URL to play.
        inlineMovie.setMovieURL(movieURL!)
        
        // Provide a poster image to be displayed in the inlineMovie interface object prior to playback.
        inlineMovie.setPosterImage(WKImage (imageName: "Ski1"))
        
        // Movie playback starts
        playingInlineMovie = false
    }
    
    @IBAction func inlineMovieTapped(sender : AnyObject) {
        if playingInlineMovie == false {
            inlineMovie.play()
        } else {
            inlineMovie.pause()
        }
    
        playingInlineMovie = !playingInlineMovie
    }
}
