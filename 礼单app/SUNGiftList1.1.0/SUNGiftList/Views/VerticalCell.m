//
//  VerticalCell.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-20.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "VerticalCell.h"

@implementation VerticalCell

- (void)dealloc {
    [_moneyLabel release];
    [_nameLabel release];
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

- (void)layoutSubviews{
    if (![SPECIAL_FONT isEqualToString:@"NO"]) {
        if (_nameLabel.text.length>3){
             _nameLabel.font = [UIFont fontWithName:@"STXingkai" size:54];
        }else{
            _nameLabel.font = [UIFont fontWithName:@"STXingkai" size:70];
        }
    }else{
        if (_nameLabel.text.length>3){
            _nameLabel.font = [UIFont boldSystemFontOfSize:50];
        }else{
            _nameLabel.font = [UIFont boldSystemFontOfSize:65];
        }
    }
    if (_moneyLabel.text.length>5){
        if (![SPECIAL_FONT isEqualToString:@"NO"]) {
            _moneyLabel.font = [UIFont fontWithName:@"STXingkai" size:38];
        }else{
            _moneyLabel.font = [UIFont boldSystemFontOfSize:35];
        }
    }else if (_moneyLabel.text.length>4) {
        if (![SPECIAL_FONT isEqualToString:@"NO"]) {
            _moneyLabel.font = [UIFont fontWithName:@"STXingkai" size:54];
        }else{
            _moneyLabel.font = [UIFont boldSystemFontOfSize:50];
        }
    }else{
        if (![SPECIAL_FONT isEqualToString:@"NO"]) {
            _moneyLabel.font = [UIFont fontWithName:@"STXingkai" size:70];
        }else{
            _moneyLabel.font = [UIFont boldSystemFontOfSize:65];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
