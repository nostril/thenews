//
//  SlotListViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventListTableView, EventDetail;

@interface EventListViewController : UITableViewController
{
	
	
}

@property (retain) NSArray *events;
@property (retain) EventListTableView *table;
@property (retain) EventDetail *eventDetail;
@property (assign) CGPoint *touchStart;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end
