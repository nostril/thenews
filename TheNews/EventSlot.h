//
//  eventSlot.h
//  test
//
//  Created by Noah Emmet on 8/25/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

#import "CurrentEvent.h"
#import "Timeslot.h"


@interface EventSlot : Timeslot {
	
//	CCSprite *sprite;
}

@property (retain) CurrentEvent *event;

-(void)test;

@end
