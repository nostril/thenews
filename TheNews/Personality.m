//
//  Personality.m
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "Personality.h"


@implementation Personality

@synthesize name, showName;
@synthesize entertaining, informative, knowledgeable;
@synthesize startingSalary;
@synthesize stats;

- (void)dealloc
{
    [name release];
    [showName release];
    [stats release];


    [super dealloc];
}


- (id) init {
    if (self = [super init])
    {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	
	
	[pool release];
    }
    
    return self;
}

+(id) loadPersonalitiesFromPlist
{
    NSDictionary *personalities = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Personalities" ofType:@"plist"]];
    
    return personalities;
}

-(id) returnPersonalityFromDictionary: (NSDictionary*) dictionary: (NSString*) name
{
    Personality *personality;
    
    
    
}

+(id) returnArrayOfPersonalitiesFromDictionary: (NSDictionary*) dictionary
{
    NSMutableArray *tempArray = [NSMutableArray new];
    
    for (id personKey in dictionary)
    {
	id personValue = [dictionary objectForKey:personKey];
	NSLog(@"personKey: %@", personKey);
	
	if([personValue isKindOfClass:[NSDictionary class]] )
	{
	   Personality *personality = [Personality new];
	   personality.name = [personValue objectForKey:@"name"];
	   personality.showName = [personValue objectForKey:@"showName"];
	   personality.startingSalary = [personValue objectForKey:@"startingSalary"];
	   personality.informative = [personValue objectForKey:@"informative"];
	   personality.entertaining = [personValue objectForKey:@"entertaining"];
	   
	   [tempArray addObject:personality];
	   NSLog(personality.name);
	   [personality release];
    //	   [personality release];
	   NSLog(@"2personality retain: %i", personality.retainCount);
	}
	
    }
    return tempArray;
}
@end
