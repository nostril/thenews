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
		
		self.name = today.name;
//		self.pastEvent = [pastEvent initWithCurrentEvent:];
		
    }
    
    return self;
}

@end
