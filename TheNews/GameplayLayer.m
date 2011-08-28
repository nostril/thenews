//
//  GameplayLayer.m
//  TheNews
//
//  Created by Noah S Emmet on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"

@implementation GameplayLayer

- (id)init
{
    self = [super init];
    if (self) 
	{
        
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		self.isTouchEnabled = YES;
		
		
		
		Week *myWeek = [Week new];
		
		NSDictionary *personalities = [Personality loadPersonalitiesFromPlist];
		
		NSArray *perArray = [Personality returnArrayOfPersonalitiesFromDictionary:personalities];
		
		
		NSLog(@"sam's show: %@", [[personalities objectForKey:@"Sam"]  objectForKey:@"showName"]);
		
		
		myWeek.monday.personality = [perArray objectAtIndex:1];
		
		NSLog(@"monday's show: %@", myWeek.monday.personality.name);
		
		[self addChild:myWeek z:1];
		
		
    }
    
    return self;
}

@end
