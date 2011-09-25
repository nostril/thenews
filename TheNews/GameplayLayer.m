//
//  GameplayLayer.m
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"



@implementation GameplayLayer

@synthesize schedule, eventListViewController;

- (id)init
{
    self = [super init];
    if (self) 
	{
        
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		self.isTouchEnabled = YES;
		
		// Initialize data
		personalities = [Personality loadPersonalitiesFromPlist];
		currentEvents = [CurrentEvent loadEventsFromPlist];
		
		schedule = [Schedule new];
		
	
		
		
		
		// Event list -- top
		eventListViewController = [[EventListViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		eventListViewController.delegate = self;
		eventListViewController.tableView.scrollEnabled = NO;
		
		eventListWrapper = [[CCUIViewWrapper alloc] initForUIView:eventListViewController.tableView];
		
		
		[self addChild: eventListWrapper];
		
		
		
		// Schedule -- bottom, horizontal
		scheduleViewController = [[ScheduleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		scheduleViewWrapper = [[CCUIViewWrapper alloc] initForUIView:scheduleViewController.tableView];
		
		scheduleViewController.schedule = schedule;
		
		[self addChild: scheduleViewWrapper];
		
		
		
		// event detail
		eventDetail = [EventDetail new];
		eventListViewController.eventDetail = eventDetail;
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
		

		
		
		// Drag and drop
		draggedEvent = [CurrentEvent new];
		draggedSprite = [CCSprite spriteWithFile:@"graphics/PaperEvent.png"];
		
		[self addChild:draggedSprite z:5];
		
//		UIPanGestureRecognizer *dragTouch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragTouchCaptured:)]; 
		
		
//		[[[CCDirector sharedDirector] openGLView].superview addGestureRecognizer:dragTouch];
		
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
    }
    
    return self;
}

-(void)BeginDraggingEvent:(CurrentEvent*)event
{
	draggedEvent = event;
	
	draggedSprite.position = CGPointMake(0, 0);
	
	[eventDetail hideDetail];
	[eventDetail showDetail:event];
	
	
}
-(void)isDraggingAtPoint:(CGPoint)dragPoint
{
	draggedSprite.position = dragPoint;
	
}
-(void)EndDraggingEvent:(UIPanGestureRecognizer*)recognizer
{
	
	CGPoint dragEndPoint = [recognizer locationInView:scheduleViewController.tableView];
	
	// This is to compensate for the scrolling of the schedule view. But it's not working. Probably because it results in a point off screen. Orrrr.... maybe it is working?
//	dragEndPoint.y += scheduleViewController.tableView.contentOffset.y;
	NSLog(@"%f, %f", scheduleViewController.tableView.contentOffset.x, scheduleViewController.tableView.contentOffset.y);
	
	
	NSIndexPath *dragdroppedIndexPath = [scheduleViewController.tableView indexPathForRowAtPoint:dragEndPoint];
	ScheduleCell* dragdroppedCell =(ScheduleCell*) [scheduleViewController.tableView cellForRowAtIndexPath:dragdroppedIndexPath];
	
	// Temporary check to see if we dragged onto current day
	if(dragdroppedIndexPath.row >= (scheduleViewController.schedule.days.count - 3))
		[dragdroppedCell.day switchCoverageToEvent:draggedEvent];
	
	
	[scheduleViewController.tableView reloadData];
	
//	[self removeChild:draggedSprite cleanup:FALSE];
	
	[eventDetail hideDetail];
}





// New touch stuff
- (void)selectSpriteForTouch:(CGPoint)touchLocation 
{
	
	
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
	
//	[[player moviePlayer] play];
	
//	[player play];
	
	[eventDetail hideDetail];
//	NSLog([[scheduleViewController.tableView indexPathForSelectedRow] row]);
	
	// This isn't being called
	[scheduleViewController.table deselectRowAtIndexPath:[scheduleViewController.table indexPathForSelectedRow] animated:TRUE];
	
	//Put this stuff in -reloadData method?
	[schedule advanceOneDay];
	[scheduleViewController.tableView reloadData];
	// Scrolls differently if there's a weekend
	if(((schedule.days.count-1) % 6) == 0)
		[scheduleViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scheduleViewController.schedule.days.count-3 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	// Friday
	if(((schedule.days.count-1) % 6) == 1)
		[scheduleViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scheduleViewController.schedule.days.count-3 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	
	// Not a weekend
	else
		[scheduleViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scheduleViewController.schedule.days.count-3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return TRUE;    
}




@end

