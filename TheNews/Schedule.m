//
//  Schedule.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize thisWeek, thisDay;

- (id)init
{
    self = [super init];
    if (self) {
		
		thisWeek = [Week new];
		
		
		pastDays = [NSMutableArray new];
		
		
		[self addChild:thisWeek z:0];
    }
    
    return self;
}

-(void) progressDay
{
	PastDay *pastDay = [[PastDay alloc] initWithDay:thisDay];
	[pastDays addObject:thisDay];
	
	[thisDay dealloc];
	thisDay = [Day new];
}
@end
