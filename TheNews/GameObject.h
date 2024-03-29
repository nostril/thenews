//
//  GameObject.h
//  TheNews
//
//  Created by Noah S Emmet on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"
#import "CommonProtocols.h"

@interface GameObject : CCSprite{
	BOOL isActive;
	BOOL reactsToScreenBoundaries;
	CGSize screenSize;
	GameObjectType gameObjectType;
}

@property (readwrite) BOOL isActive;
@property (readwrite) BOOL reactsToScreenBoundaries;
@property (readwrite) CGSize screenSize;
@property (readwrite) GameObjectType gameObjectType;

-(void) changeState: (CharacterStates) newState;
-(void) updateStateWithDeltaTime: (ccTime) deltaTimeandListOfGameObjects: (CCArray*) listOfGameObjects;
-(CGRect) adjustedBoundingBox;
-(CCAnimation*) loaPlistForAnimationWithName: (NSString*) animationNameandClassName: (NSString*) className;

@end
