//
//  Schedule.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize pastDays, today, tomorrow, dayAfterTomorrow;

- (id)init
{
    self = [super init];
    if (self) {
		dayOfTheWeek = 0;
		
		today = [[UpcomingDay alloc] initWithDayNumber:dayOfTheWeek];
		dayOfTheWeek++;
		tomorrow = [[UpcomingDay alloc] initWithDayNumber:dayOfTheWeek];
		dayOfTheWeek++;
		dayAfterTomorrow = [[UpcomingDay alloc] initWithDayNumber:dayOfTheWeek];
		dayOfTheWeek++;
		
		
		pastDays = [NSMutableArray new];
		
		
		
    }
    
    return self;
}

-(void) goToNextDay
{
	PastDay *pastDay = [[PastDay alloc] initWithDay:today];
	[pastDays addObject:today];
	
	[today dealloc];
	today = [Day new];
}
@end
