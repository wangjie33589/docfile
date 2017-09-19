//
//  CreatViewController.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftListModel.h"

@interface CreatViewController : UIViewController<UIGestureRecognizerDelegate,UITextFieldDelegate>{
    UIToolbar       *_toolBar;
    UILabel         *_titleLabel;
    UITextField     *_titleField;
    UITextField     *_timeField;
    
    UIImageView     *_titleFieldBackgroundView;
    UIImageView     *_timeFieldBackgroundView;
    
    void (^didFinish) (GiftListModel *list);
    
    GiftListModel   *_list;
}

- (id)initWithList:(GiftListModel *)list finish:(void (^)(GiftListModel *list))finish;

@end
