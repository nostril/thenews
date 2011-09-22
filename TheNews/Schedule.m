//
//  Schedule.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize days, today, tomorrow, dayAfterTomorrow;

- (id)init
{
    self = [super init];
    if (self)
	{
		
		dayNumber = 0;
		days = [NSMutableArray new];
		
		for(int startWithNDays = 4; startWithNDays > 0; startWithNDays--)
		{
			Day *day = [[Day alloc] initWithDayNumber:dayNumber];
			[days addObject:day];
			dayNumber++;
		}
		
		
		
		
		
		
    }
    
    return self;
}

-(void) advanceOneDay
{

	Day *day = [[Day alloc] initWithDayNumber:dayNumber];
	[days addObject:day];
	dayNumber++;
	
	
	
//	NSLog(@"day number total: %i",dayNumber);
	
}
@end
