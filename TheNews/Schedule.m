//
//  Schedule.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize pastDays, today, tomorrow, dayAfterTomorrow, dayNumber;

- (id)init
{
    self = [super init];
    if (self) {
		dayNumber = 0;
		
		today = [[UpcomingDay alloc] initWithDayNumber:dayNumber];
		dayNumber++;
		tomorrow = [[UpcomingDay alloc] initWithDayNumber:dayNumber];
		dayNumber++;
		dayAfterTomorrow = [[UpcomingDay alloc] initWithDayNumber:dayNumber];
		dayNumber++;
		
		
		pastDays = [NSMutableArray new];
		
		
		
    }
    
    return self;
}

-(void) goToNextDay
{
//	today.dayNumber = pastDays.count+3;
	PastDay *pastDay = [[PastDay alloc] initWithDay:today];
	[pastDays addObject:today];
	
//	today = tomorrow;
//	tomorrow = dayAfterTomorrow;
	
	dayNumber++;
	
//	[today dealloc];
	today = [today initWithDayNumber:dayNumber];
	NSLog(@"day number total: %i",dayNumber);
	
}
@end
