//
//  Day.m
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "Day.h"


@implementation Day







@synthesize name;
@synthesize personality;
@synthesize eventSlot;
@synthesize adSlot;
@synthesize day;

- (void)dealloc
{
    
    [name release];
    [personality release];
    [eventSlot release];
    [adSlot release];
    [day release];
    

    [super dealloc];
}

- (id) init
{
	if(self = [super init])
	{
//		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		day = [CCSprite spriteWithFile:@"Day.png"];
		[day setPosition: CGPointMake(0,0)];
		
		eventSlot = [CCSprite spriteWithFile:@"EventSlot.png"];
		[eventSlot setPosition: CGPointMake(0,60)];
		
		adSlot = [CCSprite spriteWithFile:@"AdSlot.png"];
		[adSlot setPosition: CGPointMake(0,30)];                
		
		[self addChild:day z:0];
		[self addChild:eventSlot z:1];
		[self addChild:adSlot z:1];
		
		
	}
	return self;
		
}

//-(id) init
//{
//    if (self = [super init])
//    {
//	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//	
//	
//	[pool release];
//    }
//    return self;
//}



@end
