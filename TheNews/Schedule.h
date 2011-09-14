//
//  Schedule.h
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

#import "Week.h"
#import "Day.h"
#import "PastDay.h"

@interface Schedule : CCNode
{
	NSMutableArray *pastDays;
	
}

@property (retain) Week *thisWeek;
@property (retain) Day *thisDay;

-(void) progressDay;
@end

