//
//  StatisticalVC.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-21.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StatisticalVCDelegate <NSObject>

- (void)sortOrCancel;

@end

@interface StatisticalVC : UIViewController{
    
    IBOutlet UITableView *_tableView;
    
    int     _peopleCount;
    int     _totalMoney;
    int     _currentPageMoney;
    BOOL    _sorted;
    
    id<StatisticalVCDelegate>      _delegate;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil peopleCount:(int)people totalMoney:(int)money currentPageMoney:(int)current sorted:(BOOL)sorted;

@property (nonatomic,assign)id<StatisticalVCDelegate>      delegate;

@end
