//
//  Day.m
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "Day.h"

#import "CCLabelTTF.h"

@implementation Day







@synthesize name;
@synthesize personality;
@synthesize background;
@synthesize dayHeader;
@synthesize dayHeaderSprite;
@synthesize eventSlot;
@synthesize adSlot;
@synthesize currentEvent;



-(id) initAtPosition: (CGPoint) position
{
	if(self = [super init])
	{
		
//		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		background = [CCSprite spriteWithFile:@"graphics/Day.png"];
		[background setPosition: CGPointMake(position.x, position.y/2)]; 
		
		dayHeaderSprite = [CCSprite spriteWithFile:@"Button.png"rect:CGRectMake(position.x, position.y, 100, 40)];
		
						   
		dayHeader = [CCLabelTTF labelWithString:@"day name" fontName:@"Futura" fontSize:36];
		[dayHeaderSprite addChild:dayHeader];
//		dayHeader = [CCLabelTTF labelWithString:name dimensions:CGSizeMake(100, 100) alignment:UITextAlignmentCenter fontName:@"Futura" fontSize:36];
		dayHeader.position = ccp(self.position.x, self.position.y);
		
		eventSlot = [Timeslot spriteWithFile:@"graphics/EventSlot.png"];
		[eventSlot setPosition: CGPointMake(position.x, position.y-105)];
		
		eventSlot.label = [CCLabelTTF labelWithString:@"empty" fontName:@"Futura" fontSize:24];
		//The (75) is a bit of a hack
		eventSlot.label.position = ccp(self.position.x+(75), self.position.y);
//		eventSlot.label.position = self.position;
//		NSLog(@"position.y: %f", position.y);
		[eventSlot addChild:eventSlot.label z:2];
		
		adSlot = [Timeslot spriteWithFile:@"graphics/AdSlot.png"];
		[adSlot setPosition: CGPointMake(position.x, position.y-195)]; 
		
		
		
		[self addChild:background z:0];
		[self addChild:dayHeaderSprite z:2];
		[self addChild:eventSlot z:1];
		[self addChild:adSlot z:1];
//		
//		NSLog(@"%f", eventSlot.boundingBox.origin.y);
//		NSLog(@"%f", adSlot.boundingBox.origin.y);
				
	}
	return self;
		
}

-(void) switchToEvent: (CurrentEvent*) newCurrentEvent
{
//	currentEvent = nil;
	currentEvent = newCurrentEvent;
	
	eventSlot.name = newCurrentEvent.name;
	
	[eventSlot.label setString:self.eventSlot.name];
//	eventSlot.label.position = eventSlot.position;
//	NSLog(@"%f", eventSlot.label.position.x);
//	[self addChild: eventSlot.label z:2];
}
-(void) test
{
	NSLog(@"Day test");
}


@end
