//
//  event.m
//  test
//
//  Created by Noah Emmet on 8/25/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "CurrentEvent.h"


@implementation CurrentEvent

@synthesize name, headline, description;



+(id) loadEventsFromPlist
{
    NSDictionary *eventDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EventList" ofType:@"plist"]];
	
	NSMutableArray *eventsArray = [NSMutableArray new];
	
    for (id eventKey in eventDict)
    {
		id eventValue = [eventDict objectForKey:eventKey];
		if([eventValue isKindOfClass:[NSDictionary class]] )
		{
			CurrentEvent *event = [CurrentEvent new];
			event.name = [eventValue objectForKey:@"name"];
			event.description = [eventValue objectForKey:@"description"];
			event.headline = [eventValue objectForKey:@"headline"];
			
			[eventsArray addObject:event];
		}
		
    }
    return eventsArray;
	
}

@end
