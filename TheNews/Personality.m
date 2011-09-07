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



- (id) init {
    if (self = [super init])
    {
		
	}
    
    return self;
}

+(id) loadPersonalitiesFromPlist
{
    NSDictionary *personalityDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Personalities" ofType:@"plist"]];
	
	NSMutableArray *personalityArray = [NSMutableArray new];
    
	
    for (id personKey in personalityDict)
    {
		id personValue = [personalityDict objectForKey:personKey];
		
		if([personValue isKindOfClass:[NSDictionary class]] )
		{
			Personality *personality = [Personality new];
			personality.name = [personValue objectForKey:@"name"];
			personality.showName = [personValue objectForKey:@"showName"];
			personality.startingSalary = (int) [personValue objectForKey:@"startingSalary"];
			personality.informative = (int) [personValue objectForKey:@"informative"];
			personality.entertaining = (int) [personValue objectForKey:@"entertaining"];
			
			[personalityArray addObject:personality];
		}
		
    }
    return personalityArray;

}

//-(id) returnPersonalityFromDictionary: (NSDictionary*) dictionary: (NSString*) name
//{
//    Personality *personality;
//    
//    
//    return personality;
//}
//
//+(id) returnArrayOfPersonalitiesFromDictionary: (NSDictionary*) dictionary
//{
//    NSMutableArray *tempArray = [NSMutableArray new];
//    
//    for (id personKey in dictionary)
//    {
//		id personValue = [dictionary objectForKey:personKey];
//		NSLog(@"personKey: %@", personKey);
//		
//		if([personValue isKindOfClass:[NSDictionary class]] )
//		{
//		   Personality *personality = [Personality new];
//		   personality.name = [personValue objectForKey:@"name"];
//		   personality.showName = [personValue objectForKey:@"showName"];
//		   personality.startingSalary = [personValue objectForKey:@"startingSalary"];
//		   personality.informative = [personValue objectForKey:@"informative"];
//		   personality.entertaining = [personValue objectForKey:@"entertaining"];
//		   
//		   [tempArray addObject:personality];
//		   NSLog(personality.name);
//		   [personality release];
//		//	   [personality release];
//		   NSLog(@"2personality retain: %i", personality.retainCount);
//		}
//	
//    }
//    return tempArray;
//}
@end
