//
//  SlotListViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlotListViewController : UITableViewController
{
	NSArray *events;
	UITableView *table;
}

@property (retain) NSArray *events;
@end
