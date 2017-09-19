//
//  ZYLoginViewController.m
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYLoginViewController.h"
#import "ZYRegisterViewController.h"



@interface ZYLoginViewController ()<UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *usrText;


@property (retain, nonatomic) IBOutlet UITextField *psdText;

@end

@implementation ZYLoginViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";

}


- (IBAction)loginBtnClick:(id)sender
{
//   调用touch方法，处理键盘下去。
    [self touchesBegan:nil withEvent:nil];
    
    
//   处理登录请求
    
    NSString *usrString = _usrText.text;
    NSString *psdString = _psdText.text;
    
    NSDictionary *dictionary = @{USER_NAME_KEY: usrString,PASSWORD_KEY:psdString};
    
    [ZYRequestTools loginAndRegisterRequest:ZYRequestTypeLogin withParameters:dictionary withCompletionBlock:^(NSDictionary *resultDictionary)
    {
        NSLog(@"login---- %@",resultDictionary);
        
        
//      与注册结果处理方式一样。
        
//       登录成功:
//       1 gotoMain
//       2 存储 access token 和 time 以便下次运行程序，直接跳转到main
        
        if ([resultDictionary[@"result"] intValue] == 1)
        {
            ALERT_DELEGATE_SHOW(@"登录成功", self);
//          2
            
            [ZYGeneralTools saveDataToLocal:resultDictionary];
            
            
        }
        else
        {
            NSString *errorString = [NSString stringWithFormat:@"登录失败:%@",resultDictionary[@"error"]];
            ALERT_SHOW(errorString);

        }
        
        
    }];
   
    
    
    
}

- (IBAction)registerBtnClick:(id)sender
{
    
    ZYRegisterViewController *registerViewController = [[ZYRegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
    
    [registerViewController release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//  1
    
    [ZYGeneralTools gotoMain];
    
}





- (void)dealloc {
    [_usrText release];
    [_psdText release];
    [super dealloc];
}
@end
