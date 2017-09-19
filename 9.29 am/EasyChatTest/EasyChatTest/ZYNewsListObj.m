//
//  ZYNewsListObj.m
//  EasyChatTest
//
//  Created by laosun on 15/9/29.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYNewsListObj.h"

@implementation ZYNewsListObj
- (void)dealloc
{
    [_newsTitle release];
    [_newsIntro release];
    [_newsSource release];
    [_newsSourceURLString release];
    [_newsImagesArray release];
    
    [super dealloc];
}
@end
