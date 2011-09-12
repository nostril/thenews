//
//  SlotListCell.m
//  TheNews
//
//  Created by Noah S Emmet on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SlotListCell.h"

@implementation SlotListCell

@synthesize event;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		event = [CurrentEvent new];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

@end
