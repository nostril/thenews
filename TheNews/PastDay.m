//
//  PastDay.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PastDay.h"
@implementation PastDay

@synthesize name, pastEvent;

- (id)initWithDay:(Day*)today
{
    self = [super init];
    if (self) {
        // Initialization code here.
		
		name = [NSString stringWithString:today.name];
		
		pastEvent = [[PastEvent alloc] initWithEvent:today.eventSlot.event];
    }
    
    return self;
}

@end
