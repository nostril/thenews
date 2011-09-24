//
//  SlotListViewController.h
//  TheNews
//
//  Created by Noah S Emmet on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCSprite;

@class EventListTableView, EventDetail, CurrentEvent;


@protocol EventListViewControllerDelegate <NSObject>;
-(void)BeginDraggingEvent:(CurrentEvent*)event;
-(void)isDraggingAtPoint:(CGPoint)dragPoint;
-(void)EndDraggingEvent:(UIPanGestureRecognizer*)recognizer;
@end




@interface EventListViewController : UITableViewController
{
	
//	CCSprite *dragbutton;
	
	CurrentEvent* draggedEvent;
}

@property (nonatomic, assign) id <EventListViewControllerDelegate> delegate;

@property (retain) NSArray *events;
@property (retain) EventListTableView *table;
@property (retain) EventDetail *eventDetail;


- (id)initWithStyle:(UITableViewStyle)style;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

//- (void)dragTouchCaptured:(UIPanGestureRecognizer *)recognizer;

@end
