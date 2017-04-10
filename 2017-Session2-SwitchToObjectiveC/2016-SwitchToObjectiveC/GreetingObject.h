//
//  GreetingObject.h
//  2016-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/3/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GreetingObject : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSDate *today;

/// Custom initialization that sets the message and timestamp
/// - parameters message: An `NSString` that holds the message to display
- (id)initWithMessage:(NSString*)message;

/// Print the message and date to the console
- (void)greetWithDate;

@end
