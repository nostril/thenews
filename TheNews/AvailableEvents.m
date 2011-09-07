//
//  AvailableEvents.m
//  TheNews
//
//  Created by Noah S Emmet on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailableEvents.h"

#import "EventSlot.h"

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
-(void) drawList
{
	for(int i=0; i<availableEvents.count; i++)
	{
		EventSlot *event = [EventSlot spriteWithFile:@"AdSlot.png"];
//		= [CCSprite spriteWithFile:@"EventSlot.png"];
		event.name = @"test name";
		
		[event setPosition: CGPointMake(100, 500 - (i * 30))];
		
		[self addChild:event z:1];
		
	}
	
}
@end
