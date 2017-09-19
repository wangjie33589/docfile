//
//  SUNTools.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-16.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLog(...)

#define IS_HIGN_CASE [[[NSUserDefaults standardUserDefaults] objectForKey:@"highCase"] isEqualToString:@"NO"]?NO:YES

#define USER_PASSWORD [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]

#define SPECIAL_FONT [[NSUserDefaults standardUserDefaults] objectForKey:@"sprcialFont"]

#define LIST_VIEW_BACKGROUND [[NSUserDefaults standardUserDefaults] objectForKey:@"listViewBackground"]

#define SAVED_ORIENTATION [[NSUserDefaults standardUserDefaults] integerForKey:@"savedImageOrientation"]

// appStore的URL
#define APP_STORE_URL @"https://itunes.apple.com/us/app/dian-zi-li-dan/id660002785"

// 意见反馈的邮箱
#define MY_EMAIL_ADDRESS @"dianzilidan@163.com"

@interface SUNTools : NSObject{
    
}

+(void)simpleAlertWithTitle:(NSString *)title message:(NSString *)message;
+(NSString *)changeNumberToHigherCase:(NSString *)number;

@end
