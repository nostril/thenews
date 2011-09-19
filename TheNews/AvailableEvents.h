//
//  AvailableEvents.h
//  TheNews
//
//  Created by Noah S Emmet on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AvailableEvents : CCNode
{
    CCSprite *sprite;
	NSMutableArray *availableEvents;
	NSMutableArray *eventList;
}

-(void) updateWithArrayOfEvents: (NSArray*) events;

@end
