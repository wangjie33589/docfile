//
//  SettingVC.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-21.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "SettingVC.h"
#import "MyMD5.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)dealloc {
    [_tableView release];
    [_higherCaseSwitch release];
    [_passwordSwitch release];
    [_toolBar release];
    [_titleLabel release];
    [_specialFontSwitch release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [self.view addSubview:_toolBar];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(finishClick)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil action:nil];
    NSArray *arr = [NSArray arrayWithObjects:item2,item, nil];
    [_toolBar setItems:arr];
    [item release];
    [item2 release];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _titleLabel.text = @"设置";
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _toolBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    _titleLabel.center = _toolBar.center;
}

#pragma mark- tableView
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"设置选项";
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%d",indexPath.row]];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:[NSString stringWithFormat:@"%d",indexPath.row]] autorelease];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"数字大写";
            if (!_higherCaseSwitch) {
                _higherCaseSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                _higherCaseSwitch.on = IS_HIGN_CASE;
                [_higherCaseSwitch addTarget:self action:@selector(switchDidChanged:) forControlEvents:UIControlEventValueChanged];
            }
            cell.accessoryView = _higherCaseSwitch;
            break;
        case 1:
            cell.textLabel.text = @"设置密码";
            if (!_passwordSwitch) {
                _passwordSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                if (USER_PASSWORD!=nil) {
                    _passwordSwitch.on = YES;
                }else{
                    _passwordSwitch.on = NO;
                }
                [_passwordSwitch addTarget:self action:@selector(passwordSwitchDidChanged:) forControlEvents:UIControlEventValueChanged];
            }
            cell.accessoryView = _passwordSwitch;
            break;
        case 2:
            cell.textLabel.text = @"隶书字体";
            if (!_specialFontSwitch) {
                _specialFontSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                if ([SPECIAL_FONT isEqualToString:@"NO"]) {
                    _specialFontSwitch.on = NO;
                }else{
                    _specialFontSwitch.on = YES;
                }
                [_specialFontSwitch addTarget:self action:@selector(specialFontSwitchDidChanged:) forControlEvents:UIControlEventValueChanged];
            }
            cell.accessoryView = _specialFontSwitch;
            break;
        case 3:
            cell.textLabel.text = @"意见反馈";
            break;
//        case 4:
//            cell.textLabel.text = @"意见反馈";
//            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        if (![MFMailComposeViewController canSendMail]) {
            [SUNTools simpleAlertWithTitle:@"提示" message:@"您还没有设置邮件账户，请在IOS系统设置中配置您的邮件账户"];
        }else{
            MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
            mailPicker.mailComposeDelegate = self;
            
                //设置主题
            [mailPicker setSubject: @"意见反馈"];
                //添加收件人
            NSArray *toRecipients = [NSArray arrayWithObject: MY_EMAIL_ADDRESS];
            [mailPicker setToRecipients: toRecipients];
            
            NSString *emailBody = @"";     
            [mailPicker setMessageBody:emailBody isHTML:YES];     
            [self presentModalViewController: mailPicker animated:YES];     
            [mailPicker release];
        }
    }
//    else if (indexPath.row == 3){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_URL]];
//    }
}
#pragma mark- buttonAction
- (void)finishClick{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark- switch

- (void)switchDidChanged:(UISwitch *)sender{
    if (sender.on) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"highCase"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"highCase"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)passwordSwitchDidChanged:(UISwitch *)sender{
    if (sender.on) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请设置密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        alert.tag = 15;
        [alert show];
        [alert release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入密码以取消密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        alert.tag = 20;
        [alert show];
        [alert release];
    }
}

- (void)specialFontSwitchDidChanged:(UISwitch *)sender{
    if (sender.on) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"sprcialFont"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"sprcialFont"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark- mailDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    [controller dismissModalViewControllerAnimated:YES];
    if (result == 2){
        [SUNTools simpleAlertWithTitle:@"提示" message:@"发送成功"];
    }
}

#pragma mark- alert
- (void)willPresentAlertView:(UIAlertView *)alertView{
    if (alertView.tag == 15) {
        UITextField *field = [alertView textFieldAtIndex:0];
        field.placeholder = @"请输入您要设置的密码";
        field.secureTextEntry = YES;
        field = [alertView textFieldAtIndex:1];
        field.placeholder = @"请再次输入密码";
    }else if (alertView.tag == 20){
        UITextField *field = [alertView textFieldAtIndex:0];
        field.placeholder = @"请输入密码";
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 15) {
        if (buttonIndex == 0) {
            [_passwordSwitch setOn:NO animated:NO];
        }else{
            if ([[alertView textFieldAtIndex:0].text isEqualToString:@""]||([alertView textFieldAtIndex:0].text == nil)) {
                [SUNTools simpleAlertWithTitle:@"提示" message:@"密码不能为空"];
                [_passwordSwitch setOn:NO animated:NO];
            }else if (![[alertView textFieldAtIndex:0].text isEqualToString:[alertView textFieldAtIndex:1].text]) {
                [SUNTools simpleAlertWithTitle:@"提示" message:@"两次密码输入不一致"];
                [_passwordSwitch setOn:NO animated:NO];
            }else{
                NSString *pass = [MyMD5 md5:[alertView textFieldAtIndex:0].text];
                [[NSUserDefaults standardUserDefaults] setObject:pass forKey:@"password"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SUNTools simpleAlertWithTitle:@"提示" message:@"密码设置成功，请牢记您的密码"];
            }
        }
    }else if (alertView.tag == 20){
        if (buttonIndex == 1) {
            NSString *pass = [MyMD5 md5:[alertView textFieldAtIndex:0].text];
            if (![pass isEqualToString:USER_PASSWORD]) {
                [SUNTools simpleAlertWithTitle:@"密码输入错误" message:nil];
                [_passwordSwitch setOn:YES animated:NO];
            }else{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SUNTools simpleAlertWithTitle:@"密码已取消" message:nil];
            }
        }else{
            [_passwordSwitch setOn:YES animated:NO];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }else{
        return NO;
    }
}


- (void)viewDidUnload {
    [_tableView release];
    _tableView = nil;
    [super viewDidUnload];
}
@end
