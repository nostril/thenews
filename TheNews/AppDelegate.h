//
//  AppDelegate.h
//  TheNews
//
//  Created by Noah S Emmet on 8/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow			*window;
	IBOutlet RootViewController	*viewController;
	
	// my stuff
	NSMutableArray *events;
}
// http://www.raywenderlich.com/4817/how-to-integrate-cocos2d-and-uikit
@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) UIWindow *window;
@property (retain) NSMutableArray *events;
@end
