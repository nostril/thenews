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

#import "Event.h"

@interface EventSlot : CCSprite {
    Event *event;
	CCSprite *eventSlot;
}

@property (retain) Event *event;


-(id) coverEvent :(Event*) event;
@end
