//
//  CreatViewController.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "CreatViewController.h"

@interface CreatViewController ()

@property (nonatomic,copy)  void (^didFinish) (GiftListModel *list);
@property (nonatomic,retain) GiftListModel *list;

@end

@implementation CreatViewController
@synthesize didFinish = didFinish,list = _list;

- (void)dealloc{
    [_toolBar release];
    [_titleField release];
    [_timeField release];
    [_titleFieldBackgroundView release];
    [_timeFieldBackgroundView release];
    [_list release];
    [_titleLabel release];
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

- (id)initWithList:(GiftListModel *)list finish:(void (^)(GiftListModel *))finish{
    self = [super init];
    if (self) {
        self.list = list;
        self.didFinish = finish;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 540, 600);
        //self.view.backgroundColor = [UIColor whiteColor];
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [self.view addSubview:_toolBar];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"取消"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(cancelClick)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(finishClick)];
    NSArray *arr = [NSArray arrayWithObjects:item1,item2,item3, nil];
    [_toolBar setItems:arr];
    [item1 release];
    [item2 release];
    [item3 release];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    if (!_list) {
        _titleLabel.text = @"新建礼单";
    }else{
        _titleLabel.text = _list.listTitle;
    }
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    _titleFieldBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 440, 50)];
    _titleFieldBackgroundView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:45];
    [self.view addSubview:_titleFieldBackgroundView];
    
    _titleField = [[UITextField alloc] initWithFrame:CGRectMake(60, 110, 430, 30)];
    _titleField.delegate = self;
    _titleField.borderStyle = UITextBorderStyleNone;
    _titleField.font = [UIFont systemFontOfSize:22];
    _titleField.placeholder = @"请输入礼单标题";
    [self.view addSubview:_titleField];
    
    if (_list) {
        _titleField.text = _list.listTitle;
    }
    
    _timeFieldBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 440, 50)];
    _timeFieldBackgroundView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:45];
    [self.view addSubview:_timeFieldBackgroundView];
    
    _timeField = [[UITextField alloc] initWithFrame:CGRectMake(60, 210, 430, 30)];
    _timeField.delegate = self;
    _timeField.borderStyle = UITextBorderStyleNone;
    _timeField.font = [UIFont systemFontOfSize:22];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    [picker addTarget:self action:@selector(datepickFinished:) forControlEvents:UIControlEventValueChanged];
    _timeField.inputView = picker;
    [picker release];
    [self.view addSubview:_timeField];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    [gesture release];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _toolBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    _titleLabel.center = _toolBar.center;
    if (_list) {
        _timeField.text = _list.creatTime;
    }else{
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *str = [format stringFromDate:[NSDate date]];
        [format release];
        _timeField.text = str;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_list) {
        [_titleField becomeFirstResponder];
    }
}

#pragma mark- buttonAction
- (void)cancelClick{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)finishClick{
    if (_titleField.text.length <= 0) {
        [SUNTools simpleAlertWithTitle:@"输入有误" message:@"标题不能为空"];
        return;
    }
    
    if (_titleField.text.length > 15) {
        [SUNTools simpleAlertWithTitle:@"输入有误" message:@"您的标题太长了吧。。。请不要超过15字"];
        return;
    }
    
    
    if (!_list) {
        _list = [[GiftListModel alloc] init];
    }
    _list.listTitle = _titleField.text;
    _list.creatTime = _timeField.text;
    
    if (didFinish) {
        didFinish(_list);
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)backgroundTap{
    [self.view endEditing:YES];
}

- (void)datepickFinished:(UIDatePicker *)picker{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [format stringFromDate:picker.date];
    [format release];
    _timeField.text = str;
}

#pragma mark- gestureDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self.view) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark- textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _titleField) {
        _titleFieldBackgroundView.image = [[UIImage imageNamed:@"inputCLICK.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:45];
    }else if (textField == _timeField){
        _timeFieldBackgroundView.image = [[UIImage imageNamed:@"inputCLICK.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:45];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _titleField) {
        _titleFieldBackgroundView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:45];
    }else if (textField == _timeField){
        _timeFieldBackgroundView.image = [[UIImage imageNamed:@"input.png"] stretchableImageWithLeftCapWidth:45 topCapHeight:45];
    }
}

#pragma mark- tool


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

@end
