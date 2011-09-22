//
//  SlotDetail.h
//  TheNews
//
//  Created by Noah S Emmet on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "CurrentEvent.h"

@interface EventDetail : CCSprite
{
//	CCSprite *background;
//	CCLabelTTF *headline;
//	CCLabelTTF *description;
//	CCSprite *graphic;
}
@property (retain) CCSprite *background;
@property (retain) CCLabelTTF *headline;
@property (retain) CCLabelTTF *description;
@property (retain) CCSprite *graphic;

@property (assign) BOOL *isShowing;


-(void) showDetail:(CurrentEvent*)event;
-(void) hideDetail;

@end
