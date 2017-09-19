//
//  GiverModel.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-18.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "GiverModel.h"

@implementation GiverModel

- (void)dealloc{
    self.name = nil;
    self.money = nil;
    self.relatedList = nil;
    self.keyNum = nil;
    [super dealloc];
}

@end
