//
//  AppDelegate.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BOOL            _passwordDidShow;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootViewController *viewController;

@end
