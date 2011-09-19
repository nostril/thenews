//
//  PastEvent.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PastEvent.h"

@implementation PastEvent

- (id)initWithCurrentEvent:(CurrentEvent*)currentEvent
{
    self = [super init];
    if (self) {
        // Initialization code here.
		self.name = [NSString stringWithString:currentEvent.name];
		self.headline = [NSString stringWithString:currentEvent.headline];
		self.description = [NSString stringWithString:currentEvent.description];
    }
    
    return self;
}

@end
