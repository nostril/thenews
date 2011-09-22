//
//  ScheduleCell.h
//  TheNews
//
//  Created by Noah S Emmet on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Day.h"

@interface ScheduleCell : UITableViewCell
{
	
}

@property (retain) Day *day;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDay:(Day*)newDay;
-(void)setFrame:(CGRect)frame;
@end
