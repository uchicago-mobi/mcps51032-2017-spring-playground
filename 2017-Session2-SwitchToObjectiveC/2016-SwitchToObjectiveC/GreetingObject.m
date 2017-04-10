//
//  GreetingObject.m
//  2016-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/3/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "GreetingObject.h"

@implementation GreetingObject

- (id)initWithMessage:(NSString*)message {
  // The init may fail, returnning nil, so it will be treated as an
  // optional in Swift
  if ( self = [super init]) {
    self.message = message;
    self.today = [NSDate date];
  }
  return self;
}


- (void)greetWithDate {
  NSLog(@"%@ on %@", self.message, self.today);
}

@end
