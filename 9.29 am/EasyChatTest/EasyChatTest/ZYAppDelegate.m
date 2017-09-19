//
//  ZYAppDelegate.m
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYAppDelegate.h"
#import "ZYGeneralTools.h"

@implementation ZYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
//  1 显示欢迎界面
    [self showWelcomeImageView];
    
    
    
    return YES;
}
- (void)showWelcomeImageView
{
    
//  ios device
//   1.png     320 * 480(3.5inch)  320 * 568(4inch)
//   1@2x.png  640 * 960           640 * 1136
//   1@3x.png  6 plus  6s plus  1080 * 1920
    UIImageView *welcomeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    
    welcomeImgView.frame = self.window.bounds;
    
    [self.window addSubview:welcomeImgView];
    
    [welcomeImgView release];
    
//  2 对welcomeImgView 执行动画 welcomeImgView 减消
    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionTransitionNone animations:^
    {
          welcomeImgView.alpha = 0.5;
    }
    completion:^(BOOL finished)
    {
        //   3 动画结束方法 执行翻转动画
        
        
        [self gotoNext];
    }];

}

- (void)gotoNext
{
    [UIView transitionWithView:self.window duration:1 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionCurlUp animations:nil
                completion:nil];
    
    
//  逻辑跟新浪微博类似。
    if ([ZYGeneralTools isLogin])
    {
        [ZYGeneralTools gotoMain];
    }
    else
    {
        //  [UIView commitAnimations] 的下面
        [ZYGeneralTools gotoLogin];
        
        //  因为不止在此会使用跳转到login的逻辑，所以跳转login可以封装成一个类的方法。
    }
    
 
}

@end








