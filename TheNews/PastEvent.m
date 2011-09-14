//
//  PastEvent.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PastEvent.h"

@implementation PastEvent
@synthesize name, headline, description;
- (id)initWithEvent:(CurrentEvent*)currentEvent
{
    self = [super init];
    if (self) {
        // Initialization code here.
		name = [NSString stringWithString:currentEvent.name];
		headline = [NSString stringWithString:currentEvent.headline];
		description = [NSString stringWithString:currentEvent.description];
    }
    
    return self;
}

@end
