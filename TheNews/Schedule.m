//
//  Schedule.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

//static int dayNumber;

@implementation Schedule


@synthesize days, today, tomorrow, dayAfterTomorrow, dayNumber;

- (id)init
{
    self = [super init];
    if (self)
	{
		
		dayNumber = 0;
		days = [NSMutableArray new];
		
		for(int startWithNDays = 3; startWithNDays > 0; startWithNDays--)
		{
//			Day *day = [[Day alloc] initWithDayNumber:dayNumber];
//			[days addObject:day];
			[days addObject:[[Day alloc] initWithDayNumber:dayNumber]];
//
			
//			[self advanceOneDay];
			dayNumber++;
		}
		
		
		
		
		
		
    }
    
    return self;
}

-(void) advanceOneDay
{

//	Day *day = [[Day alloc] initWithDayNumber:dayNumber];
//	[days addObject:day];
	[days addObject:[[Day alloc] initWithDayNumber:dayNumber]];
	dayNumber++;
	
//	NSLog(@"advance");
	
//	NSLog(@"day number total: %i",dayNumber);
	
}
@end
