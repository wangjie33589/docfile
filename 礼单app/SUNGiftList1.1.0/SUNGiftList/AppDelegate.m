//
//  AppDelegate.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "AppDelegate.h"
#import "MyMD5.h"
#import "RootViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[RootViewController alloc] init] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
//    if (USER_PASSWORD != nil) {
//        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//        backgroundView.backgroundColor = [UIColor blueColor];
//        backgroundView.tag = 50;
//        [_window addSubview:backgroundView];
//        [backgroundView release];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
//        alert.tag = 20;
//        [alert show];
//        [alert release];
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (USER_PASSWORD != nil) {
        if (!_passwordDidShow) {
            UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
                //backgroundView.backgroundColor = [UIColor blueColor];
            backgroundView.image = [UIImage imageNamed:@"Default-Landscape.png"];
            if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
                backgroundView.image = [UIImage imageWithCGImage:backgroundView.image.CGImage scale:1 orientation:UIImageOrientationRight];
            }else{
                backgroundView.image = [UIImage imageWithCGImage:backgroundView.image.CGImage scale:1 orientation:UIImageOrientationLeft];
            }
            backgroundView.tag = 50;
            [_window addSubview:backgroundView];
            [backgroundView release];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            alert.tag = 20;
            [alert show];
            _passwordDidShow = YES;
            [alert release];
        }
    }
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 20) {
        if ([alertView textFieldAtIndex:0].text == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码输入错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 25;
            [alert show];
            [alert release];
            return;
        }
        NSString *pass = [MyMD5 md5:[alertView textFieldAtIndex:0].text];
        if (![pass isEqualToString:USER_PASSWORD]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码输入错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 25;
            [alert show];
            [alert release];
        }else{
            [[_window viewWithTag:50] removeFromSuperview];
            _passwordDidShow = NO;
        }
    }else if (alertView.tag == 25){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入密码" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        alert.tag = 20;
        [alert show];
        [alert release];
    }
}

@end
