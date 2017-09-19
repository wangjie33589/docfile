//
//  ZYRegisterViewController.m
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYRegisterViewController.h"
#import "ZYRequestTools.h"


@interface ZYRegisterViewController ()<UIAlertViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField *usrText;

@property (retain, nonatomic) IBOutlet UITextField *psdText;

@property (retain, nonatomic) IBOutlet UITextField *confirmText;

@property (retain, nonatomic) IBOutlet UITextField *nicknameText;

@property (retain, nonatomic) IBOutlet UITextField *emailText;


@end

@implementation ZYRegisterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.title = @"注册";
}

//发送注册请求
- (IBAction)registerBtnClick:(id)sender
{
//  空判断 ，密码的确认判断 。。。。。。
    
    NSString *usrString = _usrText.text;
    NSString *psdString = _psdText.text;
    NSString *nicknameString = _nicknameText.text;
    NSString *emailString = _emailText.text;
    
    
//  封装成字典 减少请求方法的参数个数。  
    NSDictionary *dictionary = @{USER_NAME_KEY:usrString,PASSWORD_KEY:psdString,NICKNAME_KEY:nicknameString,EMAIL_KEY:emailString};
    
    
    [ZYRequestTools loginAndRegisterRequest:ZYRequestTypeRegister withParameters:dictionary withCompletionBlock:^(NSDictionary *resultDictionary)
     
//    [ZYRequestTools registerRequest:dictionary withCompletionBlock:^(NSDictionary *resultDictionary)
    {
        if (resultDictionary)
        {
            int resultValue = [resultDictionary[@"result"] intValue];
            if (resultValue == 1)
            {
//                注册成功
                
                ALERT_DELEGATE_SHOW(@"注册成功",self);
                
            }
            else
            {
//               注册失败，
                
                NSString *errorString = [NSString stringWithFormat:@"注册失败:%@",resultDictionary[@"error"]];
                ALERT_SHOW(errorString);
            }
        }
        
    }];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




- (void)dealloc {
    [_usrText release];
    [_psdText release];
    [_confirmText release];
    [_nicknameText release];
    [_emailText release];
    [super dealloc];
}
@end
