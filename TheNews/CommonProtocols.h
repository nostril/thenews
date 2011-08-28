//
//  CommonProtocols.h
//  TheNews
//
//  Created by Noah S Emmet on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef TheNews_CommonProtocols_h
#define TheNews_CommonProtocols_h

typedef enum{
	kCharacterTypeNone
	
}CharacterStates;

typedef enum{
	kObjectTypeNone
} GameObjectType;


@protocol GameplayerLayerDelegate
-(void) createObjectOfType: (GameObjectType) objectType
				withHealth: (int) initialHealth
				atLocation: (CGPoint) spawnLocation
				withZValue: (int) ZValue;




@end

#endif
