//
//  Week.m
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import "Week.h"
#import "Day.h"


@implementation Week

	
@synthesize week, monday, tuesday, wednesday, thursday, friday;

- (void)dealloc
{
    [monday release];
    [tuesday release];
    [wednesday release];
    [thursday release];
    [friday release];
    
    [super dealloc];
}

-(id) init
{
    if (self = [super init])
    {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		// Set all the days here
		
		

		monday = [Day new];
		monday.name = @"Monday";
		[monday setPosition: CGPointMake(100, screenSize.height*0.17f)];
		
		tuesday = [Day new];
		tuesday.name = @"Tuesday";
		[tuesday setPosition: CGPointMake(250, screenSize.height*0.17f)];
		
		wednesday = [Day new];
		wednesday.name = @"Wednesday";
		[wednesday setPosition: CGPointMake(400, screenSize.height*0.17f)];
		
		thursday = [Day new];
		thursday.name = @"Thursday";
		[thursday setPosition: CGPointMake(550, screenSize.height*0.17f)];
		
		friday = [Day new];
		friday.name = @"Friday";	
		[friday setPosition: CGPointMake(700, screenSize.height*0.17f)];
		
		                
		
		[self addChild:monday];
		[self addChild:tuesday];
		[self addChild:wednesday];
		[self addChild:thursday];
		[self addChild:friday];
		
    }
    return self;
}



@end
