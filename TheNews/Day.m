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
@synthesize dayLabel;
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
		

		
		//The x.143 is the width of the day slot
		dayLabel = [CCLabelTTF labelWithString:name dimensions:CGSizeMake(143, 100) alignment:UITextAlignmentCenter fontName:@"Futura" fontSize:26];
		dayLabel.position = ccp(position.x, position.y-60);
		
		
		eventSlot = [Timeslot spriteWithFile:@"graphics/EventSlot.png"];
		eventSlot.position=ccp(position.x, position.y-105);
		
		eventSlot.label = [CCLabelTTF labelWithString:name dimensions:CGSizeMake(143, 100) alignment:UITextAlignmentCenter fontName:@"Futura" fontSize:22];
		//The (75) is a bit of a hack... Maybe a position/2 somewhere
		eventSlot.label.position = ccp(self.position.x+73, self.position.y+5);
		[eventSlot addChild:eventSlot.label z:2];
		
		adSlot = [Timeslot spriteWithFile:@"graphics/AdSlot.png"];
		[adSlot setPosition: CGPointMake(position.x, position.y-195)]; 
		
		
		
		[self addChild:background z:0];
		[self addChild:dayLabel z:2];
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
