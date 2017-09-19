//
//  GiverCreateVC.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-20.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "GiverCreateVC.h"
#import "NumberKeyboard.h"

@interface GiverCreateVC ()

@end

@implementation GiverCreateVC
@synthesize delegate = _delegate;
@synthesize giver =_giver;

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
    NumberKeyboard *keyboard = [[NumberKeyboard alloc] init];
    keyboard.textField = _moneyField;
    [keyboard release];
    
    [_button setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                            topCapHeight:35]
                       forState:UIControlStateNormal];
    [_button setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                            topCapHeight:35]
                       forState:UIControlStateHighlighted];
    
    _nameImageView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:20];
    _moneyImageView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:20];
    if (_giver) {
        _nameField.text = _giver.name;
        _moneyField.text = _giver.money;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_nameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- buttonAction
- (IBAction)buttonClick:(UIButton *)sender {
    if (_nameField.text.length<=0) {
        [SUNTools simpleAlertWithTitle:@"输入错误" message:@"姓名不能为空"];
        return;
    }
    if (_moneyField.text.length<=0) {
        [SUNTools simpleAlertWithTitle:@"输入错误" message:@"金额不能为空"];
        return;
    }
    _button.enabled = NO;
    int money = [_moneyField.text intValue];
    if (_giver) {
        _giver.name = _nameField.text;
        _giver.money = [NSString stringWithFormat:@"%d",money];
        [_delegate editFinish];
        return;
    }
    
    GiverModel *giver = [[GiverModel alloc]init];
    giver.name = _nameField.text;
    giver.money = [NSString stringWithFormat:@"%d",money];
    [_delegate madeGiver:[giver autorelease]];
}

#pragma mark- textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _moneyField) {
        NSCharacterSet *disallowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"] ;
        for (int i = 0; i<string.length; i++) {
            NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
            NSRange foundRange = [str rangeOfCharacterFromSet:disallowedCharacters];
            if (foundRange.location == NSNotFound){
                    // 非数字
                return NO;
            }
        }
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _nameField) {
        [_moneyField becomeFirstResponder];
    }else{
        [self buttonClick:nil];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _nameField) {
        _nameImageView.image = [[UIImage imageNamed:@"inputCLICK.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:20];
    }else{
        _moneyImageView.image = [[UIImage imageNamed:@"inputCLICK.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:20];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _nameField) {
        _nameImageView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:20];
    }else{
        _moneyImageView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:20];
    }
}

- (void)dealloc {
    [_nameLabel release];
    [_nameImageView release];
    [_nameField release];
    [_moneyImageView release];
    [_moneyField release];
    [_moneyLabel release];
    [_button release];
    [_giver release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_nameLabel release];
    _nameLabel = nil;
    [_nameImageView release];
    _nameImageView = nil;
    [_nameField release];
    _nameField = nil;
    [_moneyImageView release];
    _moneyImageView = nil;
    [_moneyField release];
    _moneyField = nil;
    [_moneyLabel release];
    _moneyLabel = nil;
    [_button release];
    _button = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }else{
        return NO;
    }
}
@end
