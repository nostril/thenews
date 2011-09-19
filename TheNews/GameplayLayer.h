//
//  GameplayLayer.h
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CCLayer.h"

#import <MediaPlayer/MediaPlayer.h>

#import "CCUIViewWrapper.h"

#import "SlotListViewController.h"
#import "SlotListCell.h"
#import "SlotDetail.h"

#import "ScheduleViewController.h"

#import "Schedule.h"
#import "Day.h"
#import "Personality.h"
#import "CurrentEvent.h"
#import "AvailableEvents.h"

@interface GameplayLayer : CCLayer
{
	MPMoviePlayerController *player;
	CCUIViewWrapper *playerViewWrapper;
	
//	Week *thisWeek;
	// New touch stuff
	CCSprite * background;
	CCSprite * selSprite;
	NSArray *currentEvents;
	NSArray *personalities;
	UIButton *button;
	
	
	CCUIViewWrapper *slotListWrapper;
	SlotListViewController *slotListViewController;
	SlotDetail *slotDetail;
	
	CCUIViewWrapper *scheduleViewWrapper;
	ScheduleViewController *scheduleViewController;
	
}
@property (assign) Schedule *schedule;

@property (retain) SlotListViewController *slotListViewController;
//@property (retain) UITableView *tableView;

// New touch stuff
-(void)selectSpriteForTouch:(CGPoint)touchLocation;
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;  

@end
