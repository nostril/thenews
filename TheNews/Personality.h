//
//  Personality.h
//  test
//
//  Created by Noah Emmet on 8/10/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Personality : NSObject {
    NSString *name, *showName;
    NSInteger entertaining, informative, knowledgeable;
    NSInteger startingSalary;
    
    NSDictionary *stats;
    
}

@property (copy) NSString *name, *showName;
@property (assign) NSInteger entertaining, informative, knowledgeable, startingSalary;

@property (retain) NSDictionary *stats;

+(id) loadPersonalitiesFromPlist;
-(id) returnPersonalityFromDictionary;
+(id) returnArrayOfPersonalitiesFromDictionary;
@end

