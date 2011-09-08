//
//  Day.h
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Personality.h"
#import "EventSlot.h"
#import "AdSlot.h"

@interface Day : CCNode {
    NSString *name;
    Personality *personality;
    
	CCSprite *dayHeaderSprite;
	CCLabelTTF *dayHeader;
    EventSlot *eventSlot;
    AdSlot *adSlot;
	CCSprite *background;
	NSInteger *today;
	
	CurrentEvent *currentEvent;
	
}

@property (copy) NSString *name;
@property (retain) Personality *personality;
@property (retain) CCSprite *dayHeaderSprite;
@property (assign) CCLabelTTF *dayHeader;
@property (retain) CCSprite *background;
@property (retain) EventSlot *eventSlot;
@property (retain) AdSlot *adSlot;
@property (retain) CurrentEvent *currentEvent;

-(id) initAtPosition: (CGPoint) position;
-(void) switchToEvent: (CurrentEvent*) newEvent;
-(void) test;

@end
