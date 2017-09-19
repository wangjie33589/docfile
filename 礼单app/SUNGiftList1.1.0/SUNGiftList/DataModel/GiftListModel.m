//
//  GiftListModel.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "GiftListModel.h"

@implementation GiftListModel

- (void)dealloc{
    self.listTitle = nil;
    self.creatTime = nil;
    self.listNumber = nil;
    [super dealloc];
}

@end
