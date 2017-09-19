//
//  NumberKeyboard.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-22.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberKeyboard : UIView{
    UITextField     *_textField;
    IBOutletCollection(UIButton) NSArray *_buttonArray;
}

@property (nonatomic, assign) UITextField *textField;
@property (nonatomic,assign) id<UITextInput>delegate;

- (IBAction)singleNumberClick:(UIButton *)sender;
- (IBAction)quickButtonClick:(UIButton *)sender;
- (IBAction)defaultButtonClick:(UIButton *)sender;
- (IBAction)backClick:(UIButton *)sender;
- (IBAction)cleanButtonClick:(UIButton *)sender;

@end
