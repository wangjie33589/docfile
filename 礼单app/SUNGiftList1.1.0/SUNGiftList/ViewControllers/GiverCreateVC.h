//
//  GiverCreateVC.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-20.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiverModel.h"

@protocol GiverCreateVCDelegate <NSObject>

- (void)madeGiver:(GiverModel *)giver;
- (void)editFinish;

@end

@interface GiverCreateVC : UIViewController{
    
    IBOutlet UILabel *_nameLabel;
    IBOutlet UIImageView *_nameImageView;
    IBOutlet UITextField *_nameField;
    IBOutlet UIImageView *_moneyImageView;
    IBOutlet UITextField *_moneyField;
    IBOutlet UILabel *_moneyLabel;
    IBOutlet UIButton *_button;
    
    id<GiverCreateVCDelegate> _delegate;
    
    GiverModel  *_giver;
}

@property (nonatomic,assign)id<GiverCreateVCDelegate> delegate;
@property (nonatomic,retain)GiverModel  *giver;

@end
