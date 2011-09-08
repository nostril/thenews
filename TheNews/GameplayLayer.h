//
//  GameplayLayer.h
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CCLayer.h"


#import "CCUIViewWrapper.h"
#import "CCTableView.h"
#import "CCScrollView.h"

//#import "SWScrollView.h"
//#import "SWTableView.h"
//#import "SWMultiColumnTableView.h"

//Table stuff
#import "SlotListViewController.h"

#import "Week.h"
#import "Day.h"
#import "Personality.h"
#import "CurrentEvent.h"
#import "AvailableEvents.h"

@interface GameplayLayer : CCLayer
{
	Week *week;
	// New touch stuff
	CCSprite * background;
	CCSprite * selSprite;
	NSArray *currentEvents;
	NSArray *personalities;
	UIButton *button;
	CCUIViewWrapper *wrapper;
	
	
	UITableView *tableView;
	SlotListViewController *tableViewController;
	
}
@property (assign) Week *week;


// New touch stuff
-(void)selectSpriteForTouch:(CGPoint)touchLocation;
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;  

@end
