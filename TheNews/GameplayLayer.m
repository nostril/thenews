//
//  GameplayLayer.m
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"



@implementation GameplayLayer

@synthesize schedule, slotListViewController;

- (id)init
{
    self = [super init];
    if (self) 
	{
        
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		self.isTouchEnabled = YES;
		
		personalities = [Personality loadPersonalitiesFromPlist];
		currentEvents = [CurrentEvent loadEventsFromPlist];
		
		schedule = [Schedule new];
		
		
//		// Quick population
//		[schedule.today switchToEvent:nil];
//		[schedule.tomorrow switchToEvent:nil];
//		[schedule.dayAfterTomorrow switchToEvent:nil];
		
		
		// Slot list -- side
		slotListViewController = [[EventListViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		slotListWrapper = [[CCUIViewWrapper alloc] initForUIView:slotListViewController.tableView];
		
		[self addChild: slotListWrapper];
		
		
		// Schedule -- bottom, horizontal
		scheduleViewController = [[ScheduleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		scheduleViewWrapper = [[CCUIViewWrapper alloc] initForUIView:scheduleViewController.tableView];
		

		
		
		scheduleViewController.schedule = schedule;
		
		[self addChild: scheduleViewWrapper];
		
		
		
		// Slot detail
		eventDetail = [EventDetail new];
		slotListViewController.eventDetail = eventDetail;
		eventDetail.position = CGPointMake(screenSize.width/2, 440);
		[self addChild:eventDetail z:4];
		
		
		
		
		// Timelapse stuff
		
//		NSString *path = [[NSBundle mainBundle] pathForResource:@"graphics/cityTimeLapse" ofType:@"mp4"];
//		NSURL *movieURL = [NSURL fileURLWithPath:path];
//		
//		player = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
//		
//        [[player moviePlayer] setMovieControlMode:MPMovieControlModeHidden];
//		playerViewWrapper = [[CCUIViewWrapper alloc] initForUIView:player.view];
//		[[[[CCDirector sharedDirector] openGLView] window] addSubview:player.view];
//		
//		player.view.frame = CGRectMake(-40, 272, 1024, 500);
//		
//		
//		
//		//		player.view.transform = CGAffineTransformRotate(CGAffineTransformMakeRotation(1.0), 
//		player.view.transform = CGAffineTransformRotate(CGAffineTransformMakeRotation(0), (M_PI / 2.0));
		
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//		[[[CCDirector sharedDirector] openGLView].superview addGestureRecognizer:gestureRecognizer];
    }
    
    return self;
}
// New touch stuff
- (void)selectSpriteForTouch:(CGPoint)touchLocation 
{
	
	
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
	
	[[player moviePlayer] play];
	
//	[player play];
	
	[eventDetail hideDetail];
//	NSLog([[scheduleViewController.tableView indexPathForSelectedRow] row]);
	
	//This isn't working
	[scheduleViewController.tableView deselectRowAtIndexPath:[scheduleViewController.tableView indexPathForSelectedRow] animated:YES];
	
	//Put this stuff in -reloadData method?
	[schedule advanceOneDay];
	[scheduleViewController.tableView reloadData];
	[scheduleViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scheduleViewController.schedule.days.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return TRUE;    
}




@end

