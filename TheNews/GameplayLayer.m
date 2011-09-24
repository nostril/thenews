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
		
		personalities = [Personality loadPersonalitiesFromPlist];
		currentEvents = [CurrentEvent loadEventsFromPlist];
		
		schedule = [Schedule new];
		
	
		
		
		
		// event list -- top
		eventListViewController = [[EventListViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		eventListViewController.delegate = self;
		
		
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
//		UIPanGestureRecognizer *dragTouch = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragTouchCaptured:)]; 
		
		
//		[[[CCDirector sharedDirector] openGLView].superview addGestureRecognizer:dragTouch];
		
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
    }
    
    return self;
}
- (void)viewDidLoad
{
	NSLog(@"works!");
	
}
-(void) test
{
	
	NSLog(@"test!");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"did select delegate");
	
}

//- (void)dragTouchCaptured:(UIPanGestureRecognizer*)recognizer
//{
////	NSLog(@"gameplay layer");
//	
//	if (recognizer.state == UIGestureRecognizerStateBegan)
//	{
//		
//		NSLog(@"drag began layer") ;
//		
////		CGPoint dragBeganLocation = [recognizer locationInView:(UIView*)eventListViewController.table];
////        NSIndexPath *dragBeganIndexPath = [eventListViewController.table indexPathForRowAtPoint:dragBeganLocation];
//		
//		CGPoint location = [recognizer locationInView:(UITableView*) eventListViewController.table]; //not self.view
//		NSLog(@"(%f, %f)", location.x, location.y);
//		NSIndexPath *selectedIndexPath = [eventListViewController.table indexPathForRowAtPoint:location];
//		
//        EventListCell* dragBeganCell =(EventListCell*) [eventListViewController.table cellForRowAtIndexPath:selectedIndexPath];
//		
//		NSLog(@"%@", dragBeganCell.currentEvent.name);
//		
//		[eventDetail showDetail:dragBeganCell.currentEvent];
//		
//	}
//	else if (recognizer.state == UIGestureRecognizerStateChanged)
//	{
//
//		
//		//		NSLog(@"drag changed") ;
//		CGPoint translation = [recognizer translationInView:recognizer.view];
//        translation = ccp(translation.x, -translation.y);
////        [self panForTranslation:translation];
//        [recognizer setTranslation:CGPointZero inView:recognizer.view];
//		dragbutton.position = translation;
//	}
//	else if (recognizer.state == UIGestureRecognizerStateEnded)
//	{
//		NSLog(@"drag ended layer") ;
//		
//		CGPoint dragEndLocation = [recognizer locationInView:(UIView*)eventListViewController.table];
//        NSIndexPath *dragEndIndexPath = [eventListViewController.table indexPathForRowAtPoint:dragEndLocation];
//        EventListCell* dragEndCell =(EventListCell*) [eventListViewController.table cellForRowAtIndexPath:dragEndIndexPath];
//		
//		[eventDetail hideDetail];
//		
//		
//		dragEndCell.textLabel.textColor = [UIColor redColor];
//		[scheduleViewController.tableView reloadData];
//		NSLog(@"%@", dragEndCell.currentEvent.name);
//	}
//	
//}

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
	
	//Put this stuff in -reloadData method?
	[schedule advanceOneDay];
	[scheduleViewController.tableView reloadData];
	[scheduleViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scheduleViewController.schedule.days.count-3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return TRUE;    
}




@end

