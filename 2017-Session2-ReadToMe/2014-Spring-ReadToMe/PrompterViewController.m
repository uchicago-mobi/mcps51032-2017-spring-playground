//
//  PrompterViewController.m
//  2014-Spring-ReadToMe
//
//  Created by T. Andrew Binkowski on 4/7/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "PrompterViewController.h"

@interface PrompterViewController ()
@property AVSpeechSynthesizer *speechSynthesizer;
@end

@implementation PrompterViewController

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
                                                                   attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:50]}];
    
}

- (IBAction)tapSpeak:(id)sender
{
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.textView.text];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.pitchMultiplier = .80;
    utterance.volume = 1.0f;
    
    [self.speechSynthesizer speakUtterance:utterance];
}


-(NSString*)detectLanguage:(NSString*)string
{
    NSArray *tagschemes = [NSArray arrayWithObjects:NSLinguisticTagSchemeLanguage, nil];
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:tagschemes options:0];
    [tagger setString:string];
    NSString *language = [tagger tagAtIndex:0 scheme:NSLinguisticTagSchemeLanguage tokenRange:NULL sentenceRange:NULL];
    return language;
    
}

- (CGRect)frameOfTextRange:(NSRange)range inTextView:(UITextView *)textView
{
    
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    CGRect rect = [textView firstRectForRange:textRange];
    return [textView convertRect:rect fromView:textView];
}


//------------------------------------------------------------------------------
#pragma mark - AVSpeechSynthesizerDelegate
//------------------------------------------------------------------------------
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer
willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
        NSMutableAttributedString *text =  [[NSMutableAttributedString alloc] initWithString:self.textView.text
                                                                                  attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:50]}];
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
        self.textView.attributedText = text;

    // Scroll to talking characters
    //CGRect rangeRect=[self frameOfTextRange:characterRange inTextView:self.textView];
    //NSLog(@"Range:%@ Frame:%@",NSStringFromRange(characterRange),NSStringFromCGRect(rangeRect));
    int location = (characterRange.location > 21) ? characterRange.location + 20 : characterRange.location;
    [self.textView scrollRangeToVisible:NSMakeRange(location, characterRange.length+20)];
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
