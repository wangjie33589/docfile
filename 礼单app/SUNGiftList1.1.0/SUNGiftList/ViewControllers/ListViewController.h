//
//  ListViewController.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-18.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftListModel.h"
#import "GiverModel.h"
#import "GiverCreateVC.h"
#import "StatisticalVC.h"

@interface ListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GiverCreateVCDelegate,UIActionSheetDelegate,StatisticalVCDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImageView         *_backGroundView;
    UIImageView         *_gridImageView;
    UITableView         *_tableView;
    UIToolbar           *_downView;
    UIScrollView        *_backgroundChangeScrollView;
    GiftListModel       *_list;
    NSMutableArray      *_giverArray;
    
    UIPopoverController *_giverCreatController;
    UIPopoverController *_statisticalController;
    UIPopoverController *_imagePickerPopController;
    
    UIButton            *_exitButton;
    UILabel             *_pageNumberLabel;
    UILabel             *_titleLabel;
    int                 _currentPage;
    
    UIButton            *_leftButton;
    UIButton            *_rightButton;
    UIButton            *_countButton;
    UIButton            *_addButton;
    UIButton            *_downAddButton;
    UIButton            *_backgroudChangeButton;
    
    UIButton            *_pageChangeButton;
    BOOL                _sorted;
    
    BOOL                _listTableDidShow;
    BOOL                _backgroundChangeViewDidShow;
    UITableView         *_listTableView;
    NSMutableArray      *_listArray;
    
    BOOL                _addAnimiationGoing;
    
    int                 _giverDeleteTag;
    int                 _searchCellIndex;
    
    UIImageOrientation  _savedImageOrientation;
}

- (id)initWithList:(GiftListModel *)list;

@end
