//
//  SlotListCell.h
//  TheNews
//
//  Created by Noah S Emmet on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CurrentEvent.h"

@protocol EventListCellDelegate <NSObject>;
-(void)viewDidLoad;
-(void)test;
-(void)dragTouchCaptured:(UIPanGestureRecognizer*)recognizer;

@end

@interface EventListCell : UITableViewCell
{
	
	
}

@property (retain) CurrentEvent *currentEvent;

@property (nonatomic, assign) id <EventListCellDelegate> delegate;

@end
