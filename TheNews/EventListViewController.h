//
//  SlotListViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCSprite;

@class EventListTableView, EventDetail;






@interface EventListViewController : UITableViewController
{
	
//	CCSprite *dragbutton;
	
	
}

@property (retain) NSArray *events;
@property (retain) EventListTableView *table;
@property (retain) EventDetail *eventDetail;



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)dragTouchCaptured:(UIPanGestureRecognizer *)recognizer;

@end
