//
//  Schedule.h
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

#import "Day.h"
#import "UpcomingDay.h"
#import "PastDay.h"

@interface Schedule : CCNode
{
	
	
	
}
@property (assign) int dayNumber;
@property (retain) NSMutableArray *pastDays;
@property (retain) UpcomingDay *today, *tomorrow, *dayAfterTomorrow;

-(void) goToNextDay;
@end

