//
//  Day.h
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Event.h"
#import "CurrentEvent.h"

#import "Personality.h"

@interface Day : CCNode {
	
	
}

@property (copy) NSString *name;

//@property (assign) int dayNumber;

@property (retain) Event *event;


-(id) initWithDayNumber:(int)dayNumber;
-(void) switchToEvent: (CurrentEvent*) newEvent;


@end
