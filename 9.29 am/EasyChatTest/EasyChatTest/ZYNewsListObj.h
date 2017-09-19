//
//  ZYNewsListObj.h
//  EasyChatTest
//
//  Created by laosun on 15/9/29.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNewsListObj : NSObject

@property (nonatomic ,copy)NSString *newsTitle;
@property (nonatomic ,copy)NSString *newsIntro;
@property (nonatomic ,copy)NSString *newsSourceURLString;
@property (nonatomic ,copy)NSString *newsSource;
@property (nonatomic ,retain)NSArray *newsImagesArray;


@end
