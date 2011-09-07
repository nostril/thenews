//
//  Week.h
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

#import "Day.h"

@interface Week : CCNode {
    
	// Make this array
	CCSprite *sprite;
	NSArray *day;
	
    
}

@property (assign) CCSprite *background;
@property (assign) Day *monday, *tuesday, *wednesday, *thursday, *friday;
@property (assign) NSArray *day;

@end
