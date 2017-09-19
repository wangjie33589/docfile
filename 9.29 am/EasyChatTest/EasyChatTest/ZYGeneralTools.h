//
//  ZYGeneralTools.h
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYGeneralTools : NSObject


+ (BOOL)isLogin;

//跳转到登录。
+ (void)gotoLogin;

//跳转到主界面
+ (void)gotoMain;

+ (void)saveDataToLocal:(NSDictionary *)aDictionary;

@end
