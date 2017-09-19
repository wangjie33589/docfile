//
//  AddCell.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-20.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "AddCell.h"

@implementation AddCell

- (void)dealloc {
    [_button2 release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
