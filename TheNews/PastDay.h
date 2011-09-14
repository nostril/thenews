//
//  PastDay.h
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCNode.h"
#import "Day.h"
#import "PastEvent.h"
@interface PastDay : CCNode
{
	int dayNumber;
	
	
}
@property (assign) NSString *name;
@property (retain) PastEvent *pastEvent;

- (id)initWithDay:(Day*)today;
@end
