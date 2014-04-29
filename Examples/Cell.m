//
//  Cell.m
//  LKTaskCompletion
//
//  Created by Hiroshi Hashiguchi on 2014/04/29.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "Cell.h"

@interface Cell()

@end

@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
