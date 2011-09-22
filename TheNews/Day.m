//
//  Day.m
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "Day.h"

#import "CCLabelTTF.h"

@implementation Day







@synthesize name, event;



-(id) initWithDayNumber:(int)dayNumber
{
	if(self = [super init])
	{
		
	
		switch (dayNumber % 6)
		{
			case 0:
				name = @"Weekend";
				break;
			case 1:
				name = @"Monday";
				break;
			case 2:
				name = @"Tuesday";
				break;
			case 3:
				name = @"Wednesday";
				break;
			case 4:
				name = @"Thursday";
				break;
			case 5:
				name = @"Friday";
				break;
			default:
				
				break;
		}
	}
	
	
	[self switchCoverageToEvent:nil];
	
	return self;
		
}


-(void) switchCoverageToEvent: (CurrentEvent*) newCurrentEvent
{
	if(newCurrentEvent == nil)
	{
		event.name = @"Empty";
		event.headline = @"Empty";
		event.description = @"Empty";
	}
	else
		event = newCurrentEvent;
}



@end
