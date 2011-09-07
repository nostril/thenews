//
//  Week.m
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "Week.h"
#import "Day.h"


@implementation Week

	
@synthesize background;
@synthesize monday, tuesday, wednesday, thursday, friday;
@synthesize day;

-(id) init
{
    if (self = [super init])
    {
		
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		
		
		sprite = [CCSprite spriteWithFile:@"graphics/WeekBG.png"];
		[sprite setPosition: CGPointMake(screenSize.width/2, sprite.contentSize.height/2)];
		
		NSMutableArray *tempDay = [NSMutableArray new];
		
		for(int dayNumber = 0; dayNumber < 5; dayNumber++){
			Day *newDay = [[Day alloc] initAtPosition:CGPointMake(dayNumber*200+114, sprite.contentSize.height)];
			
			// Give weekday names
			switch (dayNumber) {
				case 0:
					newDay.name = @"Monday";
					break;
				case 1:
					newDay.name = @"Tuesday";
					break;
				case 2:
					newDay.name = @"Wednesday";
					break;
				case 3:
					newDay.name = @"Thursday";
					break;
				case 4:
					newDay.name = @"Friday";
					break;
				default:
					break;
			}
			
			// Sets position of days
//			[newDay.eventSlot setPosition:CGPointMake(dayNumber*200+114, sprite.contentSize.height-105)];
//			[newDay.adSlot setPosition:CGPointMake(dayNumber*200+114, sprite.contentSize.height-195)];
//			[newDay.background setPosition:CGPointMake(dayNumber*200+114, sprite.contentSize.height/2)];

			[self addChild:newDay z:1];
			[tempDay addObject:newDay];
		}
		
		day = [[NSArray alloc] initWithArray:tempDay];
		
		
		
		[self addChild:sprite z:0];
		
    }
    return self;
}

@end
