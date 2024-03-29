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

#import "EventListViewController.h"
#import "EventListCell.h"
#import "EventDetail.h"

#import "ScheduleViewController.h"

#import "CCVideoPlayer.h"

#import "Schedule.h"
#import "Day.h"
#import "Personality.h"
#import "CurrentEvent.h"
#import "AvailableEvents.h"

@interface GameplayLayer : CCLayer <EventListViewControllerDelegate>
{
	MPMoviePlayerController *player;
	CCUIViewWrapper *playerViewWrapper;
	
	CCSprite * background;
	
	NSArray *currentEvents;
	NSArray *personalities;
	UIButton *button;
	
	CCSprite *dragbutton;
	
	CCUIViewWrapper *eventListWrapper;
	EventListViewController *eventListViewController;
	EventDetail *eventDetail;
	
	CCUIViewWrapper *scheduleViewWrapper;
	ScheduleViewController *scheduleViewController;
	
	
	CurrentEvent *draggedEvent;
	CCSprite *draggedSprite;
	
}
@property (assign) Schedule *schedule;

@property (retain) EventListViewController *eventListViewController;
//@property (retain) UITableView *tableView;

// New touch stuff
-(void)selectSpriteForTouch:(CGPoint)touchLocation;
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;  
//- (void)dragTouchCaptured:(UIPanGestureRecognizer*)recognizer;


@end
