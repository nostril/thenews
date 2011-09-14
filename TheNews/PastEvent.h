//
//  PastEvent.h
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "CurrentEvent.h"

@interface PastEvent : CCNode
{
	
    
}
@property (assign) NSString *name, *headline, *description;
- (id)initWithEvent:(CurrentEvent*)currentEvent;

@end
