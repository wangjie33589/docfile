//
//  RootViewController.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIImageView         *_backgroundImageView;
    UITableView         *_tableView;
    
    NSMutableArray      *_giftListArray;
    
    int                 _deleteRow;
    
    UILabel             *_emptyLabel;
}

@end
