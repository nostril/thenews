//
//  Timeslot.h
//  TheNews
//
//  Created by Noah S Emmet on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Timeslot : CCSprite {
    NSString *name;
	CCLabelTTF *label;
	
}
@property (retain) NSString *name;
@property (assign) CCLabelTTF *label;
+(void) switchTimeslot;
-(void) test;
@end

