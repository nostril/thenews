//
//  GameplayLayer.m
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"



@implementation GameplayLayer

@synthesize week, tableViewController;

- (id)init
{
    self = [super init];
    if (self) 
	{
        
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		self.isTouchEnabled = YES;
		
		personalities = [Personality loadPersonalitiesFromPlist];
		currentEvents = [CurrentEvent loadEventsFromPlist];
		
		
		week = [Week new];
		[self addChild:week z:1];
		

		
		// Quick population
		for (Day *eachDay in week.day){
			[eachDay switchToEvent:[currentEvents objectAtIndex:(arc4random() % currentEvents.count)]];
		}
		
		
		// Table Stuff Begins ––––––––––––––––––––––––––––––––––––––––––––––––
		
		tableViewController = [[SlotListViewController alloc] initWithStyle:UITableViewStyleGrouped];
		
		wrapper = [[CCUIViewWrapper alloc] initForUIView:tableViewController.tableView];
		
		[self addChild: wrapper];
		
		// Table Stuff Ends ––––––––––––––––––––––––––––––––––––––––––––––––––
		
		
		slotDetail = [SlotDetail new];
		slotDetail.position = CGPointMake(600, 550);
		[self addChild:slotDetail z:4];
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
    
    return self;
}
// New touch stuff
- (void)selectSpriteForTouch:(CGPoint)touchLocation 
{
    CCSprite * newSprite = nil;
	
	
	
//	[tableViewController.table deselectRowAtIndexPath:[tableViewController.table indexPathForSelectedRow] animated:YES];
////	NSLog(@"touch");
//	[[tableViewController tableView] reloadData];
	
	
	// Selects any sprite
    for (Day *day in week.day) 
	{
		//Events
		if (CGRectContainsPoint(day.eventSlot.boundingBox, touchLocation)) 
		{            
            newSprite = day.eventSlot;
			
			
			CurrentEvent *tempEvent;
			tempEvent = [[CurrentEvent alloc] init];
			tempEvent = [[CurrentEvent alloc] init];

			
			// Well... this is a bit of a hack
			tempEvent = [tableViewController.events objectAtIndex:[[tableViewController.tableView indexPathForSelectedRow]row]];
			[day switchToEvent:tempEvent];
			
			[slotDetail hideDetail];
			[slotDetail showDetail:tempEvent];
			
			
            break;
        }
		//Ads
		else if (CGRectContainsPoint(day.adSlot.boundingBox, touchLocation)) 
		{            
            newSprite = day.adSlot;
			NSLog(@"ad slot touched");
//			[day switchToEvent:[currentEvents objectAtIndex:(arc4random() % 2)]];
            break;
        }
		else
		{
			[slotDetail hideDetail];
			
		}
    }
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

