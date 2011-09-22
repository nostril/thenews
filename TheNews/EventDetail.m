//
//  SlotDetail.m
//  TheNews
//
//  Created by Noah S Emmet on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetail.h"

@implementation EventDetail

@synthesize background, headline, description, graphic, isShowing;

- (id)init
{
    self = [super init];
    if (self) {
		

		isShowing=FALSE;
		
		
		

    }
    
    return self;
}
-(void) showDetail:(CurrentEvent*)event
{
	NSLog(@"show detail: %@", event.name);
	background = [CCSprite spriteWithFile:@"graphics/PaperSheet.png"];
	[background setPosition: CGPointMake(0,0)];
//	[background setPosition: CGPointMake(self.position.x, self.position.y/2)]; 
	
	headline = [CCLabelTTF labelWithString:event.headline dimensions:CGSizeMake(540, 200) alignment:UITextAlignmentLeft fontName:@"Futura" fontSize:40];
	[headline setColor:ccc3(0, 0, 0)];
	headline.position = ccp(0, 80);
	
	description = [CCLabelTTF labelWithString:event.description dimensions:CGSizeMake(300, 300) alignment:UITextAlignmentLeft fontName:@"Futura" fontSize:18];
	[description setColor:ccc3(0, 0, 0)];
	description.position = ccp(100, -25);
	
	graphic = [CCSprite spriteWithFile:@"graphics/TempGraphic.png"];
	graphic.position = ccp(-200, -20);
	
	[self addChild:background z:0];
	[self addChild:graphic z:1];
	[self addChild:headline z:1];
	[self addChild:description z:1];
	
	
	isShowing=TRUE;
}
-(void) hideDetail
{
	[self removeAllChildrenWithCleanup:FALSE];
	
	isShowing=FALSE;
}
@end
