//
//  AddPicViewController.m
//  HorizontalScrollViewDemo
//
//  Created by Reese on 13-6-14.
//  Copyright (c) 2013年 Reese. All rights reserved.
//

#import "AddPicViewController.h"
#import <QuartzCore/QuartzCore.h>
#define  PIC_WIDTH 80
#define  PIC_HEIGHT 80
#define  INSETS 10


@interface AddPicViewController ()

@end

@implementation AddPicViewController

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
    self.navigationItem.title=@"添加图片";
    addedPicArray =[[NSMutableArray alloc]init];
    [self refreshScrollView];
    // Do any additional setup after loading the view from its nib.
}


- (void)refreshScrollView
{
    CGFloat width=100*(addedPicArray.count)<300?320:100+addedPicArray.count*90;
    
    CGSize contentSize=CGSizeMake(width, 100);
    [_picScroller setContentSize:contentSize];
    [_picScroller setContentOffset:CGPointMake(width<320?0:width-320, 0) animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [addedPicArray release];
    [_picScroller release];
    [_plusButton release];
    [super dealloc];
}
- (IBAction)clearPics:(id)sender {
     for (UIImageView *img in addedPicArray)
     {
         [img removeFromSuperview];
     }
    [addedPicArray removeAllObjects];
    
    CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(_plusButton.center.x, _plusButton.center.y)]];
    [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(INSETS+PIC_WIDTH/2, _plusButton.center.y)]];
    [positionAnim setDelegate:self];
    [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [positionAnim setDuration:0.25f];
    
    [_plusButton.layer addAnimation:positionAnim forKey:nil];
    
    [_plusButton setCenter:CGPointMake(INSETS+PIC_WIDTH/2, _plusButton.center.y)];
    [self refreshScrollView];
}

- (IBAction)addPic:(id)sender {
    
    //移动添加按钮
    CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
    [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(_plusButton.center.x, _plusButton.center.y)]];
    [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(_plusButton.center.x+INSETS+PIC_WIDTH, _plusButton.center.y)]];
    [positionAnim setDelegate:self];
    [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [positionAnim setDuration:0.25f];
    [_plusButton.layer addAnimation:positionAnim forKey:nil];
    [_plusButton setCenter:CGPointMake(_plusButton.center.x+INSETS+PIC_WIDTH, _plusButton.center.y)];
    
    //添加图片
    UIImageView *aImageView=[[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"boy"]]autorelease];
    [aImageView setFrame:CGRectMake(INSETS-90, INSETS, PIC_WIDTH, PIC_HEIGHT)];
    [addedPicArray addObject:aImageView];
    [_picScroller addSubview:aImageView];
    
    for (UIImageView *img in addedPicArray) {
        
        CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
        [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(img.center.x, img.center.y)]];
        [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(img.center.x+INSETS+PIC_WIDTH, img.center.y)]];
        [positionAnim setDelegate:self];
        [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [positionAnim setDuration:0.25f];
        [img.layer addAnimation:positionAnim forKey:nil];
        
        [img setCenter:CGPointMake(img.center.x+INSETS+PIC_WIDTH, img.center.y)];
    }
    
    
    
    [self refreshScrollView];
}
@end
