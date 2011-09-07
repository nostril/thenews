//
//  RootViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 8/1/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventTableView.h"
#import "EventTableViewController.h"


@interface RootViewController : UIViewController 
{
	EventTableViewController *eventTableView;
	IBOutlet EventTableViewController *eventTableViewController;
	
}
@property (retain) EventTableViewController *eventTableView;
@property (nonatomic, retain) IBOutlet EventTableViewController *tableView;
@end
