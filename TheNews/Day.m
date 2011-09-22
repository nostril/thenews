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
		NSLog(@"dayNumber %i ./. 5 = %i", dayNumber, (dayNumber % 5));
		
	
		switch (dayNumber % 5)
		{
			case 0:
				name = @"Monday";
				break;
			case 1:
				name = @"Tuesday";
				break;
			case 2:
				name = @"Wednesday";
				break;
			case 3:
				name = @"Thursday";
				break;
			case 4:
				name = @"Friday";
				break;
			default:
				break;
		}
				
	}
	
//	[self switchToEvent:nil];
	
	return self;
		
}


-(void) switchToEvent: (CurrentEvent*) newCurrentEvent
{

}



@end
