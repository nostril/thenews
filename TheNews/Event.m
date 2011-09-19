//
//  Event.m
//  TheNews
//
//  Created by Noah S Emmet on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event


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
			Event *event = [Event new];
			event.name = [eventValue objectForKey:@"name"];
			event.description = [eventValue objectForKey:@"description"];
			event.headline = [eventValue objectForKey:@"headline"];
			
			[eventsArray addObject:event];
		}
		
    }
    return eventsArray;
	
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
