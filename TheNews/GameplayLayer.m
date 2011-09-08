//
//  GameplayLayer.m
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"



@implementation GameplayLayer

@synthesize week;

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
		
//		AvailableEvents *availableEvents = [AvailableEvents new];
//		[availableEvents updateWithArrayOfEvents:currentEvents];
//		[self addChild:availableEvents z:1];
		
		// Quick population
		for (Day *eachDay in week.day){
			[eachDay switchToEvent:[currentEvents objectAtIndex:(arc4random() % currentEvents.count)]];
		}
		
		
		// Table Stuff Begins ––––––––––––––––––––––––––––––––––––––––––––––––
		
		tableViewController = [[SlotListViewController alloc] initWithStyle:UITableViewStylePlain];
		
		wrapper = [[CCUIViewWrapper alloc] initForUIView:tableViewController.tableView];
		
		[self addChild: wrapper];
		
		// Table Stuff Ends ––––––––––––––––––––––––––––––––––––––––––––––––––
		
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
    
    return self;
}
// New touch stuff
- (void)selectSpriteForTouch:(CGPoint)touchLocation 
{
    CCSprite * newSprite = nil;
	
	
	// Selects any sprite
    for (Day *day in week.day) 
	{

        if (CGRectContainsPoint(day.eventSlot.boundingBox, touchLocation)) 
		{            
            newSprite = day.eventSlot;
			[day switchToEvent:[currentEvents objectAtIndex:(arc4random() % currentEvents.count)]];
            break;
        }
		else if (CGRectContainsPoint(day.adSlot.boundingBox, touchLocation)) 
		{            
            newSprite = day.adSlot;
			NSLog(@"ad slot touched");
//			[day switchToEvent:[currentEvents objectAtIndex:(arc4random() % 2)]];
            break;
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

