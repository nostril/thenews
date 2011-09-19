//
//  SlotListViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlotListTableView, SlotDetail;

@interface SlotListViewController : UITableViewController
{
	
	
}

@property (retain) NSArray *events;
@property (retain) SlotListTableView *table;
@property (retain) SlotDetail *slotDetail;
@end
