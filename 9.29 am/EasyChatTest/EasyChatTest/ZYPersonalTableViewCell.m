//
//  ZYPersonalTableViewCell.m
//  EasyChatTest
//
//  Created by laosun on 15/9/28.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYPersonalTableViewCell.h"

@implementation ZYPersonalTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    
    _headerImgView.layer.cornerRadius = 30;
    _headerImgView.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headerImgView release];
    [super dealloc];
}
@end
