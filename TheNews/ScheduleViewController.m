//
//  ScheduleViewController.m
//  TheNews
//
//  Created by Noah S Emmet on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define TODAY_CELL_WIDTH 260
#define UPCOMING_CELL_WIDTH 240
#define PAST_CELL_WIDTH 200
#define WEEKEND_CELL_WIDTH 400

#import "ScheduleViewController.h"
#import "cocos2d.h"


@implementation ScheduleViewController

@synthesize schedule, table, eventDetail;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		
		UISwipeGestureRecognizer *gesture = 
		[[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToNextDay:)] autorelease];
		[gesture setDirection:UISwipeGestureRecognizerDirectionUp];
		[self.tableView addGestureRecognizer:gesture];
		

		CGSize screenSize = [CCDirector sharedDirector].winSize;
		
		// This isn't getting used... maybe need to rename to tableView to override
		table = [ScheduleTableView new];
		
		[super viewDidLoad];
		
		CGAffineTransform trans = self.view.transform; // get current transform (i.e. portrait)
		trans = CGAffineTransformRotate(trans, (M_PI / -2.0)); // rotate 90 degrees to go landscape
		self.view.transform = trans; // set current transform (landscape)
		
		self.view.frame = CGRectMake(0, 550, 1024, 200);
		
		[self.view addSubview:table];
		table.delegate=self;
		table.dataSource=self;
		
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Custom cell widths
	if ((indexPath.row % 6) == 0)
		return WEEKEND_CELL_WIDTH;
	else if(((schedule.days.count) - indexPath.row) == 3)
		return TODAY_CELL_WIDTH;
	else if (((schedule.days.count) - indexPath.row) <= 2)
		return UPCOMING_CELL_WIDTH;
	else 
		return PAST_CELL_WIDTH;
}

-(void)swipeToNextDay:(UIGestureRecognizer *)gestureRecognizer {
	
	if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
		CGPoint offset = self.tableView.contentOffset;
		CGRect bounds = self.tableView.bounds;
		CGSize size = self.tableView.contentSize;
		UIEdgeInsets inset = self.tableView.contentInset;
		float y = offset.y + bounds.size.height - inset.bottom;
		float h = size.height;
//		 NSLog(@"offset: %f", offset.y);   
//		 NSLog(@"content.height: %f", size.height);   
//		 NSLog(@"bounds.height: %f", bounds.size.height);   
//		 NSLog(@"inset.top: %f", inset.top);   
//		 NSLog(@"inset.bottom: %f", inset.bottom);   
//		 NSLog(@"pos: %f of %f", y, h);
		
		float reload_distance = 200;
		if(y > h - reload_distance) {
			
			NSLog(@"swiped!");
			[schedule advanceOneDay];
			[self.tableView reloadData];
			[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:schedule.days.count-3 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
		}
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    // because dequeueReusable returns a UITableCell by default
    ScheduleCell *cell = (ScheduleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withDay:[schedule.days objectAtIndex:indexPath.row]] autorelease];
		
		cell.textLabel.transform = CGAffineTransformMakeRotation( M_PI/2 );
		//Not sure what accessory type is
		//		cell.accessoryType = UITableViewCellAccessoryNone;
		
		
		cell.day = [schedule.days objectAtIndex:indexPath.row];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	cell.textLabel.numberOfLines = 3;
	cell.textLabel.textColor = [UIColor blackColor];
	
	
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.textLabel.font = [UIFont fontWithName:@"Futura" size:26];
	
	cell.textLabel.backgroundColor = [UIColor lightGrayColor];
	
	// If this has an event
	if([[schedule.days objectAtIndex:indexPath.row] event])
		cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",[[schedule.days objectAtIndex:indexPath.row] name], [[[schedule.days objectAtIndex:indexPath.row] event]name]];
	else
		cell.textLabel.text = [NSString stringWithFormat:@"%@\nNo Event",[[schedule.days objectAtIndex:indexPath.row] name]];

	
	switch (schedule.days.count - indexPath.row) {
			
			// Today
		case 3:
			cell.textLabel.textColor = [UIColor blueColor];
			cell.textLabel.backgroundColor = [UIColor whiteColor];
			break;
			// Tomorrow
		case 2:
			cell.textLabel.textColor = [UIColor blackColor];
			cell.textLabel.backgroundColor = [UIColor whiteColor];
			
			break;
			// Day after tomorrow
		case 1:
			cell.textLabel.textColor = [UIColor blackColor];
			cell.textLabel.backgroundColor = [UIColor whiteColor];
			
			break;
			
		default:
			break;
	}
	
	
	
	
	
	
	
	
	
	
	//	[table scrollToRowAtIndexPath:(indexPath) atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	
    return cell;
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
	table = [ScheduleTableView new];
    [super viewDidLoad];
//	
	

	
	[self.view addSubview:table];
	table.delegate=self;
	table.dataSource=self;

	
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
	// The plus three is for today, tomorrow, and the dayAfterTomorrow
    return (schedule.days.count);
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	
}

@end
