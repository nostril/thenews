//
//  GameObject.m
//  TheNews
//
//  Created by Noah S Emmet on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize reactsToScreenBoundaries;
@synthesize screenSize;
@synthesize isActive;
@synthesize gameObjectType;

-(id)init
{
    self = [super init];
    if (self) {
		CCLOG(@"GameObject init");
		screenSize = [CCDirector sharedDirector].winSize;
		isActive = TRUE;
		gameObjectType = kObjectTypeNone;
    }
    
    return self;
}

-(void) changeState:(CharacterStates) newState
{
	CCLOG(@"GameObject -> changeState method should be overridden. ");
}

-(void) updateStateWithDeltaTime:(ccTime)deltaTimeandListOfGameObjects :(CCArray *)listOfGameObjects 
{
	CCLOG(@"updateStateWithDeltaTime method should be overridden. ");
}

-(CGRect) adjustedBoundingBox
{
	CCLOG(@"adjustedBoundingBox method should be overridden. ");
	return [self boundingBox];
}

-(CCAnimation*) loaPlistForAnimationWithName: (NSString*) animationNameandClassName: (NSString*) className{
	

}
@end
