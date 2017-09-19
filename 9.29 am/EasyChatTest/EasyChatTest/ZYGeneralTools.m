//
//  ZYGeneralTools.m
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYGeneralTools.h"
#import "ZYLoginViewController.h"


#import "ZYHomePageViewController.h"
#import "ZYNewsViewController.h"
#import "ZYFileViewController.h"
#import "ZYPersonalViewController.h"


@implementation ZYGeneralTools

+ (void)gotoLogin
{
   
    
    ZYLoginViewController *viewController = [[ZYLoginViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = navigationController;
    
    
    [viewController release];
    [navigationController release];
    
    
}

//把获取老window的方法独立,以后可以在其他的+方法中使用self.window调用下面的方法获得window对象。
+ (UIWindow *)window
{
    return [[[UIApplication sharedApplication] delegate] window];
}



// 主界面：tabbarController（主页，新闻，文件，个人）
+ (void)gotoMain
{
    
//   主页
    ZYHomePageViewController *viewController1 = [[ZYHomePageViewController alloc] init];
    
    
//  如果只设置viewController1的title，则上下（tabbarItem和navigationItem的title都一致，这不是我想要的。）
//    viewController1.title = @"主页";
    viewController1.navigationItem.title = @"聊天中心";
    viewController1.tabBarItem.title = @"主页";
    
    viewController1.tabBarItem.image = [UIImage imageNamed:@"main.png"];
    
    
    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    
    [viewController1 release];
    
//   新闻
    ZYNewsViewController *viewController2 = [[ZYNewsViewController alloc] init];
    
    viewController2.navigationItem.title = @"新闻中心";
    
    viewController2.tabBarItem.title = @"新闻";
    
    viewController2.tabBarItem.image = [UIImage imageNamed:@"news.png"];
    
    
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
    [viewController2 release];
    
//    文件
    ZYFileViewController *viewController3 = [[ZYFileViewController alloc] init];
    
    
    viewController3.navigationItem.title = @"文件中心";
    
    viewController3.tabBarItem.title = @"文件";
    
    viewController3.tabBarItem.image = [UIImage imageNamed:@"file.png"];
    
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
    [viewController3 release];
    
//   个人
    ZYPersonalViewController *viewController4 = [[ZYPersonalViewController alloc] init];
    
    viewController4.navigationItem.title = @"个人中心";
    
    viewController4.tabBarItem.title = @"个人";
    
    viewController4.tabBarItem.image = [UIImage imageNamed:@"person.png"];
    
    UINavigationController *navigationController4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
    [viewController4 release];
    
    
//  tabbarController
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[navigationController1,navigationController2,navigationController3,navigationController4];
    
    [navigationController1 release];
    [navigationController2 release];
    [navigationController3 release];
    [navigationController4 release];
    
    
    
    self.window.rootViewController = tabbarController;
   
    [tabbarController release];
    
    
}
+ (void)saveDataToLocal:(NSDictionary *)aDictionary
{
//  access token
//  expires date
    
    NSString *tokenString = aDictionary[@"access_token"];
    
    long long timeValue = [aDictionary[@"time"] longLongValue];
    NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:timeValue];
    
    
    [USER_DEFALUTS setObject:tokenString forKey:ACCESS_TOKEN_KEY];
    [USER_DEFALUTS setObject:expiresDate forKey:EXPIRES_DATE_KEY];
    [USER_DEFALUTS synchronize];
    
}

+ (BOOL)isLogin
{
    NSString *accessTokenString = [USER_DEFALUTS objectForKey:ACCESS_TOKEN_KEY];
    NSDate *expiresDate = [USER_DEFALUTS objectForKey:EXPIRES_DATE_KEY];
    
    
    return accessTokenString&&([expiresDate compare:[NSDate date]] == NSOrderedDescending);

}







@end
