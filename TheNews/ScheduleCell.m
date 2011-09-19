//
//  ScheduleCell.m
//  TheNews
//
//  Created by Noah S Emmet on 9/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

@synthesize day;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier atDayNumber:(int)dayNumber
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		day = [[Day alloc] initWithDayNumber:dayNumber];
		
		

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
//    frame.origin.x += inset;
//    frame.size.width = 200;
    [super setFrame:frame];
}
@end
