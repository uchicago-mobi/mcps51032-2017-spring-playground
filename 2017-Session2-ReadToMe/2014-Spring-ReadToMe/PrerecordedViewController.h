//
//  PrerecordedViewController.h
//  2016-Spring-ReadToMe
//
//  Created by T. Andrew Binkowski on 4/7/16.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

@import AVFoundation;

@interface PrerecordedViewController : UIViewController

/// The text view holding the sentence
@property (weak, nonatomic) IBOutlet UITextView *textView;

/// Track the time
@property (nonatomic,retain) NSDate *timeZero;

/// Keep track of what word we are on
@property int wordIndex;

/// Audio playter
@property (nonatomic,retain) AVAudioPlayer *audioPlayer;

/// The string on the screen
@property (retain, nonatomic) NSMutableAttributedString *attributedString;


/// When tapped begine the read to me function
- (IBAction)tapSpeakToMe:(id)sender;

@end
