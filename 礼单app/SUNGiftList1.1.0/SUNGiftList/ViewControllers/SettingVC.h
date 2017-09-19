//
//  SettingVC.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-21.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingVC : UIViewController<MFMailComposeViewControllerDelegate>{
     UIToolbar       *_toolBar;
    IBOutlet UITableView *_tableView;
    
    UISwitch        *_higherCaseSwitch;
    UISwitch        *_passwordSwitch;
    UISwitch        *_specialFontSwitch;
    UILabel         *_titleLabel;
}

@end
