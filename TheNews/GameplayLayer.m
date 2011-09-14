//
//  GameplayLayer.m
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"



@implementation GameplayLayer

@synthesize thisWeek, slotListViewController;

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
		
		//		thisWeek = [Week new];
//		[self addChild:thisWeek z:1];

		
		[self addChild:schedule z:1];
		
		
		
		// Quick population
		for (Day *eachDay in schedule.thisWeek.day){
			[eachDay switchToEvent:nil];
		}
		
		
		// Slot list -- side
		slotListViewController = [[SlotListViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		slotListWrapper = [[CCUIViewWrapper alloc] initForUIView:slotListViewController.tableView];
		
		[self addChild: slotListWrapper];
		
		
		// Schedule -- bottom, horizontal
		scheduleViewController = [[ScheduleViewController alloc] initWithStyle:UITableViewStylePlain];
		
		scheduleViewWrapper = [[CCUIViewWrapper alloc] initForUIView:scheduleViewController.tableView];
		
		[self addChild: scheduleViewWrapper];
		
		
		// Slot detail
		slotDetail = [SlotDetail new];
		slotListViewController.slotDetail = slotDetail;
		slotDetail.position = CGPointMake(600, 550);
		[self addChild:slotDetail z:4];
		
		
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
    
    return self;
}
// New touch stuff
- (void)selectSpriteForTouch:(CGPoint)touchLocation 
{
	
	// Think I'll have to sorta use the for loop as fodder for a switch case later down. The switch case looks at what is and isn't selected, decides what to display or eventswitch.
    CCSprite * newSprite = nil;
	
	
	// Selects any sprite
    for (Day *day in thisWeek.day) 
	{
		//Events
		if (CGRectContainsPoint(day.eventSlot.boundingBox, touchLocation)) 
		{            
            newSprite = day.eventSlot;
			
			
			CurrentEvent *tempEvent;
			tempEvent = [[CurrentEvent alloc] init];
			
			
			
			// Well... this is a bit of a hack
			tempEvent = [slotListViewController.events objectAtIndex:[[slotListViewController.tableView indexPathForSelectedRow]row]];
			
			if(slotDetail.isShowing)
			{
				[day switchToEvent:tempEvent];
				
				[slotDetail hideDetail];
			}
			else{
				// This is returning null. No, it's not.
				[slotDetail showDetail:day.currentEvent];
//				NSLog(day.currentEvent.name);
			}
			
			
            break;
        }
		//Ads
		else if (CGRectContainsPoint(day.adSlot.boundingBox, touchLocation)) 
		{            
            newSprite = day.adSlot;
			NSLog(@"ad slot touched");
			
            break;
        }
		
    }
	// If no slots are tapped
	
	// Here's the problem. Hiding detail no matter what.
	[slotDetail hideDetail];
	[slotListViewController.tableView deselectRowAtIndexPath:[slotListViewController.tableView indexPathForSelectedRow] animated:TRUE];
	
	// Selecting sprite for first time
    if (newSprite != selSprite) {
		
		
		
		
		

        selSprite = newSprite;
		
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];      
    return TRUE;    
}




@end

