//
//  event.h
//  test
//
//  Created by Noah Emmet on 8/25/11.
//  Copyright 2011 Kaiser Sunnyside. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Event : NSObject {
    NSString *name;
    NSString *headline, *description;
}

@property (copy) NSString *name, *headline, *description;

@end


