//
//  ScheduleViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScheduleTableView.h"
#import "ScheduleCell.h"
#import "Schedule.h"

@interface ScheduleViewController : UITableViewController 
{
	ScheduleTableView *table;
	
}
@property (retain) Schedule *schedule;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)swipeToNextDay:(UIGestureRecognizer *)gestureRecognizer;


@end
