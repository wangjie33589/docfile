//
//  ZYPersonalViewController.m
//  EasyChatTest
//
//  Created by laosun on 15/9/28.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYPersonalViewController.h"

#import "ZYPersonalTableViewCell.h"

@interface ZYPersonalViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>


@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZYPersonalViewController


//定义一个字符串常量。
NSString *const customCellIdentifier = @"cell";

NSString *const systemCellIdentifier = @"cell1";

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configView];
}
- (void)configView
{
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZYPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:customCellIdentifier];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  section == 1?3:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZYPersonalTableViewCell *cell = nil;
    
//   只有第一区 使用custom cell。其余使用的是default system cell。
    if (indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier forIndexPath:indexPath];
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:systemCellIdentifier forIndexPath:indexPath];
        
//        cell.textLabel.text = @"laosun";
        
        cell.textLabel.text = indexPath.section == 1?(indexPath.row == 0?@"清理图片缓存":indexPath.row == 1?@"清理文件缓存":@"退出登录"):@"关于我们";
        
/*
        switch (indexPath.section)
        {
            case 1:
            {
                
                
                cell.textLabel.text = indexPath.row == 0?@"清理图片缓存":indexPath.row == 1?@"清理文件缓存":@"退出登录";
                
//                switch (indexPath.row)
//                {
//                    case 0:
//                    {
//                        cell.textLabel.text = @"清理图片缓存";
//                    }
//                        break;
//                    case 1:
//                    {
//                        cell.textLabel.text = @"清理文件缓存";
//                    }
//                        break;
//                    case 2:
//                    {
//                        cell.textLabel.text = @"退出登录";
//                    }
//                        break;
//                        
//                    default:
//                        break;
//                }
            }
                break;
                
            case 2:
            {
                cell.textLabel.text = @"关于我们";
            }
                break;
            default:
                break;
        }
        
        */
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.section == 0?80:60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
//   第一区 跳转到二级界面
//   其余都是弹出警告框
    switch (indexPath.section) {
        case 0:
        {
//           跳转到个人设置界面
        }
            break;
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    ALERT_DELEGATE_TAG_SHOW(@"确定清理图片缓存？", self, 1);
                }
                    break;
                case 1:
                {
                    ALERT_DELEGATE_TAG_SHOW(@"确定清理文件缓存？", self, 2);
                    
                }
                    break;
                case 2:
                {
//                    ALERT_DELEGATE_TAG_SHOW(@"确定退出登录？", self, 3);
                    
                    NSLog(@"登出");
                    //  NO.1 发送注销请求
                    //  NO.2 如果请求成功，删除access token 和expires date
                    //  NO.3 如果请求成功，跳转到登录界面
                    
                    [ZYRequestTools loginOutWithCompletionBlock:^(NSDictionary *resultDic)
                     {
                         
                         
                         NSLog(@"resultDic---- %@",resultDic);
                         if (resultDic)
                         {
                             
                             ALERT_DELEGATE_TAG_SHOW(resultDic[@"info"], self, 3);
                         }
                     }];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            ALERT_SHOW(@"关于我们");
        }
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case 1:
        {
            NSLog(@"图片");
        }
            break;
        case 2:
        {
             NSLog(@"文件");
        }
            break;
//       登出 
        case 3:
        {
            // 2
            [USER_DEFALUTS removeObjectForKey:ACCESS_TOKEN_KEY];
            [USER_DEFALUTS removeObjectForKey:EXPIRES_DATE_KEY];
            [USER_DEFALUTS synchronize];
            
            // 3
            [ZYGeneralTools gotoLogin];
        }
            break;
        default:
            break;
    }
}

#pragma mark -





- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}
@end
