//
//  AddPicViewController.h
//  HorizontalScrollViewDemo
//
//  Created by Reese on 13-6-14.
//  Copyright (c) 2013年 Reese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPicViewController : UIViewController
{
    NSMutableArray *addedPicArray;
}
@property (retain, nonatomic) IBOutlet UIScrollView *picScroller;
@property (retain, nonatomic) IBOutlet UIButton *plusButton;
- (IBAction)clearPics:(id)sender;
- (IBAction)addPic:(id)sender;

@end
