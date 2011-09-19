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
		
		
		// Quick population
		[schedule.today switchToEvent:nil];
		[schedule.tomorrow switchToEvent:nil];
		[schedule.dayAfterTomorrow switchToEvent:nil];
		
		
		// Slot list -- side
		slotListViewController = [[SlotListViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		slotListWrapper = [[CCUIViewWrapper alloc] initForUIView:slotListViewController.tableView];
		
		[self addChild: slotListWrapper];
		
		
		// Schedule -- bottom, horizontal
		scheduleViewController = [[ScheduleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		scheduleViewWrapper = [[CCUIViewWrapper alloc] initForUIView:scheduleViewController.tableView];
		
		scheduleViewController.schedule = schedule;
		
		[self addChild: scheduleViewWrapper];
		
		
		
		// Slot detail
		slotDetail = [SlotDetail new];
		slotListViewController.slotDetail = slotDetail;
		slotDetail.position = CGPointMake(600, 550);
		[self addChild:slotDetail z:4];
		
		
		
		// Timelapse stuff

		
//		player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:@"graphics/cityTimeLapse.mp4"]];
//		[player.view setFrame:CGRectMake(0, 0, 1024, 786)];  // player's frame must match parent's
//		playerViewWrapper = [[CCUIViewWrapper alloc] initForUIView:player.view];
//		[self addChild: playerViewWrapper z:-1];
//		
//		[player play];

		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
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
	
	[slotDetail hideDetail];
//	NSLog([[scheduleViewController.tableView indexPathForSelectedRow] row]);
	
	//This isn't working
	[scheduleViewController.tableView deselectRowAtIndexPath:[scheduleViewController.tableView indexPathForSelectedRow] animated:YES];
	
	//Put this stuff in -reloadData method?
	[scheduleViewController.tableView reloadData];
	[scheduleViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scheduleViewController.schedule.pastDays.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return TRUE;    
}




@end

