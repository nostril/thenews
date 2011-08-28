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

@interface Week : CCSprite {
    
	// Make this array
	CCSprite *week;
	Day *monday, *tuesday, *wednesday, *thursday, *friday;
	
	
    
}

@property (assign) CCSprite *week;
@property (assign) Day *monday, *tuesday, *wednesday, *thursday, *friday;



@end
