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


@protocol EventListViewControllerDelegate <NSObject>;
-(void)viewDidLoad;
-(void)test;
-(void)dragTouchCaptured:(UIPanGestureRecognizer*)recognizer;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end




@interface EventListViewController : UITableViewController
{
	
//	CCSprite *dragbutton;
	
	
}

@property (nonatomic, assign) id <EventListViewControllerDelegate> delegate;

@property (retain) NSArray *events;
@property (retain) EventListTableView *table;
@property (retain) EventDetail *eventDetail;


- (id)initWithStyle:(UITableViewStyle)style;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)dragTouchCaptured:(UIPanGestureRecognizer *)recognizer;

@end
