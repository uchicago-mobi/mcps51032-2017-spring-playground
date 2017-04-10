//
//  PrerecordedViewController.m
//  2016-Spring-ReadToMe
//
//  Created by T. Andrew Binkowski on 4/7/16.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "PrerecordedViewController.h"

///
///
///
@interface PrerecordedViewController ()
@property (strong,nonatomic) NSArray *timeTextSegments;
@end


///
///
///
@implementation PrerecordedViewController

//------------------------------------------------------------------------------
//
#pragma mark -  Lifecycle
//
//------------------------------------------------------------------------------


- (void)loadView
{
  [super loadView];
  
  // Laod in the text to time file
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QuickBrown" ofType:@"plist"];
  _timeTextSegments = [NSArray arrayWithContentsOfFile:filePath];
  
  // Create a dictionary of time to speak each word
  NSMutableString *str = [[NSMutableString alloc] init];
  for (NSDictionary *segment in self.timeTextSegments) {
    NSString *word = [segment valueForKey:@"word"];
    [str appendString:[NSString stringWithFormat:@"%@ ",word]];
  }
  
  // Create the attributed string and set to the text view
  self.attributedString = [[NSMutableAttributedString alloc] initWithString:str];
  self.textView.attributedText = self.attributedString;
}


- (void)viewWillAppear:(BOOL)animated
{
  // Load audio file and get it read to play
  NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/QuickFox.wav", [[NSBundle mainBundle] resourcePath]]];

  NSError *error;
  _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

  if (self.audioPlayer == nil) {
    NSLog(@"Error:%@",[error description]);
  }
}


- (IBAction)tapSpeakToMe:(id)sender
{
  // Begin the audio player
  [self.audioPlayer play];
  
  // Set a timer on each word with a delay time interval.  There will be as many
  // timers as there are words.  We start all the timers at the same time to
  // minimize any odd delays that would occur from continous time monitoring.
  // This proved more accurate then measuring the exact time on each word
  NSUInteger startIndex = 0;
  for (int i=0; i < [self.timeTextSegments count]; i++) {
    NSString *word = [[self.timeTextSegments objectAtIndex:i] valueForKey:@"word"];
    NSNumber *start = [[self.timeTextSegments objectAtIndex:i] valueForKey:@"start"];
    NSValue *theRange = [NSValue valueWithRange:NSMakeRange(startIndex,[word length])];
    [NSTimer scheduledTimerWithTimeInterval:[start doubleValue]
                                     target:self
                                   selector:@selector(updateAttributedString:)
                                   userInfo:theRange
                                    repeats:NO];
    startIndex += ([word length] + 1);
  }
  
  // Update the string in the text view
  self.textView.attributedText = self.attributedString;
}


//------------------------------------------------------------------------------
//
#pragma mark -  Formatting
//
//------------------------------------------------------------------------------


/// When each word is being spoken, highlight it and clear all the formatting off
/// any other words.
- (void)updateAttributedString:(NSTimer *)incomingTimer
{
  NSLog(@"userInfo: %@", [incomingTimer userInfo]);
  NSValue *range = [incomingTimer userInfo];
  
  [self.attributedString addAttribute:NSBackgroundColorAttributeName
                                value:[UIColor clearColor]
                                range:NSMakeRange(0, [self.attributedString.mutableString length])];
  
  [self.attributedString addAttribute:NSBackgroundColorAttributeName
                                value:[UIColor greenColor]
                                range:[range rangeValue]];
  
  self.textView.attributedText = self.attributedString;
}


@end
