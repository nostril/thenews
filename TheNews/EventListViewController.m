//
//  SlotListViewController.m
//  TheNews
//
//  Created by Noah S Emmet on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventListViewController.h"
#import "EventListTableView.h"
#import "EventListCell.h"
#import "EventDetail.h"
#import "CurrentEvent.h"

@implementation EventListViewController

@synthesize events, table, eventDetail, delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		
		draggedEvent = [CurrentEvent new];
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 200;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
	table = [EventListTableView new];
	events = [CurrentEvent loadEventsFromPlist];
    [super viewDidLoad];
	
	CGAffineTransform trans = self.view.transform; // get current transform (i.e. portrait)
	trans = CGAffineTransformRotate(trans, (M_PI / -2.0)); // rotate 90 degrees to go landscape
	self.view.transform = trans;
	self.view.frame = CGRectMake(10, 0, 1014, 120);
	
	
	[self.view addSubview:table];
	table.delegate=self;
	table.dataSource=self;

	UIPanGestureRecognizer *dragTouch = [[UIPanGestureRecognizer alloc] 
										 initWithTarget:self action:@selector(dragTouchCaptured:)]; 
	
	[[[CCDirector sharedDirector] openGLView].superview addGestureRecognizer:dragTouch];

	

}


- (void)dragTouchCaptured:(UIPanGestureRecognizer*)recognizer
{
	// Eventually this will have to detect if user tapped on event paper. 
	
	if (recognizer.state == UIGestureRecognizerStateBegan)
	{
		CGPoint dragBeginLocation = [recognizer locationInView:self.table];
		
        NSIndexPath *dragBeginIndexPath = [self.tableView indexPathForRowAtPoint:dragBeginLocation];
        EventListCell* dragBeginCell =(EventListCell*) [self.tableView cellForRowAtIndexPath:dragBeginIndexPath];
		
		
		draggedEvent=dragBeginCell.currentEvent;
		if(draggedEvent)
			[delegate BeginDraggingEvent:draggedEvent];

	}
	else if (recognizer.state == UIGestureRecognizerStateChanged)
	{
		CGPoint dragPoint = [recognizer locationInView:[CCDirector sharedDirector].openGLView];
		
		dragPoint.y = [[CCDirector sharedDirector]winSize].height - dragPoint.y;
		
		if(draggedEvent)
			[delegate isDraggingAtPoint:dragPoint];
		
	}
	else if (recognizer.state == UIGestureRecognizerStateEnded)
	{
		CGPoint dragPoint = [recognizer locationInView:[CCDirector sharedDirector].openGLView];
		dragPoint.y = [[CCDirector sharedDirector]winSize].height - dragPoint.y;
		
		if(draggedEvent)
			[delegate EndDraggingEvent:recognizer];
		
		draggedEvent = nil;
		
	}
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
	
    // Return the number of rows in the section.
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SlotListCell";
	
    // because dequeueReusable returns a UITableCell by default
    EventListCell *cell = (EventListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[EventListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//Not sure what accessory type is
//		cell.accessoryType = UITableViewCellAccessoryNone;
		
		cell.textLabel.transform = CGAffineTransformMakeRotation( M_PI/2 );
    }
    cell.currentEvent = [self.events objectAtIndex:indexPath.row];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	cell.textLabel.numberOfLines = 3;
	cell.textLabel.textColor = [UIColor blackColor];
	
	
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.textLabel.font = [UIFont fontWithName:@"Futura" size:20];
	
	cell.textLabel.backgroundColor = [UIColor lightGrayColor];

	
	 
	cell.textLabel.text = cell.currentEvent.name;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
//	NSLog(@"selected! %i: %@", [[tableView indexPathForSelectedRow]row], [[(SlotListCell*)[self.tableView cellForRowAtIndexPath:indexPath] event ]name] );
	if(eventDetail.isShowing)
		[eventDetail hideDetail];
	else
		[eventDetail showDetail: [events objectAtIndex:[[tableView indexPathForSelectedRow]row]]];

	
	
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
