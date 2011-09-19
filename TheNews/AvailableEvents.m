//
//  AvailableEvents.m
//  TheNews
//
//  Created by Noah S Emmet on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailableEvents.h"



@implementation AvailableEvents
-(id) init
{
    if (self = [super init])
    {
		
		sprite = [CCSprite spriteWithFile:@"graphics/Day.png"];
		[sprite setPosition: CGPointMake(100, 550)];
		
		[self addChild:sprite z:0];
		
		availableEvents = [NSMutableArray new];
		
	}
	return self;
}

-(void) updateWithArrayOfEvents: (NSArray*) events
{
	[availableEvents removeAllObjects];
	[availableEvents addObjectsFromArray:events];
	[self drawList];
	
}

@end
