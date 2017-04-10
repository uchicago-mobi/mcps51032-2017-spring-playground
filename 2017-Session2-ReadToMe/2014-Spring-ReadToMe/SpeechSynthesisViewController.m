//
//  ViewController.m
//  2014-Spring-ReadToMe
//
//  Created by T. Andrew Binkowski on 4/4/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "SpeechSynthesisViewController.h"


///
///
///
@interface SpeechSynthesisViewController ()
@property AVSpeechSynthesizer *speechSynthesizer;
@end


///
///
///
@implementation SpeechSynthesisViewController

//------------------------------------------------------------------------------
//
#pragma mark - Lifecycle
//
//------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.speechSynthesizer.delegate = self;
    [self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text
                                                                    attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:30]}];
}


//------------------------------------------------------------------------------
//
#pragma mark -  Speech Synthesis Tricks
//
//------------------------------------------------------------------------------


/// Begin speaking when the user taps the bar button
- (IBAction)tapSpeak:(id)sender
{
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.textView.text];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.pitchMultiplier = .20;
    utterance.volume = 1.0f;
    
    [self.speechSynthesizer speakUtterance:utterance];
}



//------------------------------------------------------------------------------
//
#pragma mark -  Speech Synthesis Tricks
//
//------------------------------------------------------------------------------


// Just for fun, detect what language is being spoken
- (NSString*)detectLanguage:(NSString*)string
{
    NSArray *tagschemes = [NSArray arrayWithObjects:NSLinguisticTagSchemeLanguage, nil];
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:tagschemes options:0];
    [tagger setString:string];
    NSString *language = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeLanguage tokenRange:NULL sentenceRange:NULL];
    return language;
    
}

//------------------------------------------------------------------------------
//
#pragma mark - AVSpeechSynthesizerDelegate
//
//------------------------------------------------------------------------------

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
    willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
  NSMutableAttributedString *text =  [[NSMutableAttributedString alloc] initWithString:self.textView.text
                                                                             attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:30]}];
   [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
   self.textView.attributedText = text;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
 didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
   // self.textView.attributedText = [[NSMutableAttributedString alloc] initWithString:self.textView.text
   //                                                                       attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:50],
   //                                                                              NSUnderlineStyleAttributeName : @1}];


}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
  didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    //self.textView.attributedText = [[NSMutableAttributedString alloc] initWithString:self.textView.text
     //                                                              attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:50],
     //                                                                            NSUnderlineStyleAttributeName : @1}];
}

@end
