//
//  Event.h
//  TheNews
//
//  Created by Noah S Emmet on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"

@interface Event : CCNode
{
	
}


@property (copy) NSString *name, *headline, *description;

+(id) loadEventsFromPlist;
@end
