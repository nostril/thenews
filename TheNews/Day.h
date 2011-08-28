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

@interface Day : CCSprite {
    NSString *name;
    Personality *personality;
    
    EventSlot *eventSlot;
    AdSlot *adSlot;
	CCSprite *day;
}

@property (copy) NSString *name;
@property (retain) Personality *personality;
@property (retain) EventSlot *eventSlot;
@property (retain) AdSlot *adSlot;
@property (retain) CCSprite *day;

-(void) dealloc;

@end
